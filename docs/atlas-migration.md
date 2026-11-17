# Atlas マイグレーション用の Cloud SQL 権限

`fun-dotto/server` の GitHub Actions（`migrate.yml`）から Atlas で DB マイグレーションを実行するための設定。
設計は `fun-dotto/server` の `docs/design/20261110_atlas_migration.md` を参照。

## Terraform で管理しているもの

| 対象 | 場所 |
| --- | --- |
| SA `gha-server-migrate-dry-run-<env>`（読み取り専用）/ `gha-server-migrate-apply-<env>`（DDL）。`<env>` は `dev` / `stg` / `prd` | `terraform/google/foundation/iam-workload-identity/service_account_github-actions-server-migrate.tf` |
| 各 SA の `roles/cloudsql.client` / `roles/cloudsql.instanceUser` | 同上 |
| Cloud SQL の IAM ユーザー（`<sa>@swift2023groupc.iam`）と所属ロール | `terraform/google/foundation/cloud-sql/users.tf` |
| WIF 属性 `attribute.repository_environment` | `terraform/google/foundation/iam-workload-identity/identity_pool_provider_github.tf` |
| `fun-dotto/server` の必須ステータスチェック `Migration`（`migrate.yml` の集約ジョブ） | `terraform/github/fun-dotto/repository-server.tf` |
| ロール（`dotto_admin_<env>` など）とロール間のメンバーシップ | `terraform/google/foundation/cloud-sql-roles/roles.tf` |
| スキーマ・テーブルの権限、default privileges、`atlas_schema_revisions` スキーマ | `terraform/google/foundation/cloud-sql-roles/privileges.tf` |

`cloud-sql-roles` は terraform-ci の IAM ユーザー（`cloudsqlsuperuser`）で接続する。`google_sql_user` の `database_roles` が参照するロールを作るため、`cloud-sql` より先に apply する。

ロール構成の全体像は [postgresql_roles.md](./postgresql_roles.md) を参照。

### 環境ごとの権限分離

- dry-run 用 SA: `fun-dotto/server` の任意のワークフローから借用可（読み取り専用のため）。環境ごとに別 SA で、対応する `dotto_migrate_readonly_<env>` にのみ所属する。
- 適用用 SA: `attribute.repository_environment` が `fun-dotto/server/<env>` のジョブのみ、同名の環境の SA を借用可。PR の dry-run ジョブは Environment を指定しないので借用できない。`prd` は GitHub Environment 側の承認者必須・保護ブランチ限定で守る。
- 適用用 SA は `dotto_admin_<env>` のメンバー。接続時に `role=dotto_admin_<env>`（`SET ROLE`）を指定して DDL を実行する。

## 手動で実施する SQL（Terraform の管理外）

DB への `CONNECT` と、既存オブジェクトの owner の付け替えは Terraform の管理外。Cloud SQL の組み込みユーザー（`cloudsqlsuperuser` のメンバー）で実施する。

### terraform-ci に既存ロールの ADMIN OPTION を付与する（初回のみ）

PostgreSQL 16 以降は、`CREATEROLE` を持っていても `ADMIN OPTION` のあるロールしか変更できない。手動で作ったロールを Terraform で管理するため、Cloud SQL の組み込みユーザー（`cloudsqlsuperuser` のメンバー）で実行する（2026-11-17 に実施済み）。Terraform が新しく作るロールには自動で付く。

```sql
GRANT dotto_developer,
  dotto_admin_dev, dotto_admin_stg, dotto_admin_prd,
  dotto_service_dev, dotto_service_stg, dotto_service_prd,
  dotto_migrate_readonly_dev, dotto_migrate_readonly_stg, dotto_migrate_readonly_prd
  TO "terraform-ci@swift2023groupc.iam" WITH ADMIN OPTION;
```

### 各 DB での接続制限と owner

DB は dev が `dotto_dev`、stg が `dotto_stg`、prd が `dotto`。対象 DB に接続して実行する。

```sql
-- 接続制限: 他環境のロールから接続できないようにする
REVOKE CONNECT ON DATABASE <db> FROM PUBLIC;
GRANT CONNECT ON DATABASE <db> TO cloudsqlsuperuser, dotto_developer,
  dotto_admin_<env>, dotto_service_<env>, dotto_migrate_readonly_<env>;

-- 既存オブジェクトの owner を環境用ロールにする
-- （旧構成から移行する場合のみ）旧 dotto_admin が所有するオブジェクトを付け替える
REASSIGN OWNED BY dotto_admin TO dotto_admin_<env>;
```

### dotto_admin ロールの削除

`dotto_admin` は廃止した。旧メンバーの人 3 名は Terraform（`google_sql_user.developer`）で `dotto_developer` のみに所属させる。
先に Terraform を apply して所属を切り替えてから、`cloudsqlsuperuser` のメンバーで次を実行する。

```sql
-- 1. 所属を確認（dotto_admin のメンバーが残っていないこと）
SELECT r.rolname AS role, m.rolname AS member
FROM pg_auth_members am
JOIN pg_roles r ON r.oid = am.roleid
JOIN pg_roles m ON m.oid = am.member
WHERE 'dotto_admin' IN (r.rolname, m.rolname);

-- 2. 各 DB（dotto_dev / dotto_stg / dotto / postgres）に接続して、それぞれ実行する
--    <env_role> は dotto_dev→dotto_admin_dev、dotto_stg→dotto_admin_stg、dotto→dotto_admin_prd。
--    postgres DB では REASSIGN を省略し DROP OWNED のみ。
REASSIGN OWNED BY dotto_admin TO <env_role>;
DROP OWNED BY dotto_admin;  -- 残った権限付与・DEFAULT PRIVILEGES を削除

-- 3. いずれかの DB で 1 回
DROP ROLE dotto_admin;
```

`DROP ROLE` が `role "dotto_admin" cannot be dropped because some objects depend on it` で失敗した場合は、エラーに出た DB で手順 2 が漏れている。

## 未対応（ワークフロー導入後に実施）

- 既存の `migrate` / `apply-table-privileges` Cloud Run Job（Terraform 管理外）の実在確認と削除。
