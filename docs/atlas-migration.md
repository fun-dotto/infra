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

ロール構成の全体像は [postgresql_roles.md](./postgresql_roles.md) を参照。

### 環境ごとの権限分離

- dry-run 用 SA: `fun-dotto/server` の任意のワークフローから借用可（読み取り専用のため）。環境ごとに別 SA で、対応する `dotto_migrate_readonly_<env>` にのみ所属する。
- 適用用 SA: `attribute.repository_environment` が `fun-dotto/server/<env>` のジョブのみ、同名の環境の SA を借用可。PR の dry-run ジョブは Environment を指定しないので借用できない。`prd` は GitHub Environment 側の承認者必須・保護ブランチ限定で守る。
- 適用用 SA は `dotto_admin_<env>` のメンバー。接続時に `role=dotto_admin_<env>`（`SET ROLE`）を指定して DDL を実行する。

## 手動で実施する SQL（Terraform の管理外）

ロール自体と DB 内の権限は Terraform の管理外。新しい環境の DB を作る場合や、ロール構成を変える場合は、人間の管理者（`dotto_admin` のメンバー）が実施する。
Terraform の `google_sql_user` が `database_roles` で参照するロールは、先に作成しておく必要がある。

### ロールの作成（インスタンスで 1 回）

```sql
CREATE ROLE dotto_admin_<env> NOLOGIN;
CREATE ROLE dotto_service_<env> NOLOGIN;
CREATE ROLE dotto_migrate_readonly_<env> NOLOGIN;

GRANT dotto_admin_<env> TO dotto_admin;
GRANT dotto_service_<env> TO dotto_admin_<env>;
```

### 各 DB での権限設定

DB は dev が `dotto_dev`、stg が `dotto_stg`、prd が `dotto`。対象 DB に接続して実行する。

```sql
-- 接続制限: 他環境のロールから接続できないようにする
REVOKE CONNECT ON DATABASE <db> FROM PUBLIC;
GRANT CONNECT ON DATABASE <db> TO cloudsqlsuperuser, dotto_admin, dotto_developer,
  dotto_admin_<env>, dotto_service_<env>, dotto_migrate_readonly_<env>;

-- 既存オブジェクトの owner を環境用ロールにする
REASSIGN OWNED BY dotto_admin TO dotto_admin_<env>;

-- 新規テーブルへの自動権限付与（dotto_admin_<env> が作るテーブル）
ALTER DEFAULT PRIVILEGES FOR ROLE dotto_admin_<env>
  GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO dotto_service_<env>;
-- dotto_developer: dev / stg は CRUD、prd は SELECT のみ
ALTER DEFAULT PRIVILEGES FOR ROLE dotto_admin_<env>
  GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO dotto_developer;  -- prd は GRANT SELECT ON TABLES
```

`serial` / `bigserial` を使うテーブルがある場合は、シーケンスの `USAGE` も同様に `ALTER DEFAULT PRIVILEGES ... ON SEQUENCES` で付与する。
設定内容は `SELECT pg_get_userbyid(defaclrole) AS creator, defaclobjtype, defaclacl FROM pg_default_acl;` で確認できる。

### 既存テーブルの権限

| ロール | dotto_dev / dotto_stg | dotto (prd) |
| --- | --- | --- |
| `dotto_admin_<env>` | owner、`ALL` | owner、`ALL` |
| `dotto_service_<env>` | `SELECT, INSERT, UPDATE, DELETE` | `SELECT, INSERT, UPDATE, DELETE` |
| `dotto_developer` | `SELECT, INSERT, UPDATE, DELETE` | **`SELECT` のみ** |
| `dotto_migrate_readonly_<env>` | `atlas_schema_revisions` の `SELECT` | 同左 |

```sql
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO dotto_service_<env>;
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO dotto_developer;  -- prd は SELECT のみ
-- prd のみ、developer の書き込み権限が残っている場合
REVOKE INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public FROM dotto_developer;

-- dry-run 用: リビジョンテーブルは public ではなく専用スキーマ atlas_schema_revisions にある
-- （スキーマ・テーブルが無い DB では、マイグレーションを初めて適用した後に実行する）
GRANT USAGE ON SCHEMA atlas_schema_revisions TO dotto_migrate_readonly_<env>;
GRANT SELECT ON TABLE atlas_schema_revisions.atlas_schema_revisions TO dotto_migrate_readonly_<env>;
```

## 未対応（ワークフロー導入後に実施）

- `terraform/github/fun-dotto/repository-server.tf` の `required_status_checks` に `migrate.yml` のチェック名を追加する。先に追加すると、まだ存在しないチェックを待ってマージ不能になるため、`fun-dotto/server` 側のワークフローが main に入ってから行う。
- 既存の `migrate` / `apply-table-privileges` Cloud Run Job（Terraform 管理外）の実在確認と削除。
