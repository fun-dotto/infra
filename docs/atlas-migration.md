# Atlas マイグレーション用の Cloud SQL 権限

`fun-dotto/server` の GitHub Actions（`migrate.yml`）から Atlas で DB マイグレーションを実行するための設定。
設計は `fun-dotto/server` の `docs/design/20261110_atlas_migration.md` を参照。

## Terraform で管理しているもの

| 対象 | 場所 |
| --- | --- |
| SA `gha-server-migrate-dry-run`（読み取り専用）/ `gha-server-migrate-apply`（DDL） | `terraform/google/foundation/iam-workload-identity/service_account_github-actions-server-migrate.tf` |
| 各 SA の `roles/cloudsql.client` / `roles/cloudsql.instanceUser` | 同上 |
| Cloud SQL の IAM ユーザー（`<sa>@swift2023groupc.iam`） | `terraform/google/foundation/cloud-sql/users.tf` |
| WIF 属性 `attribute.repository_environment` | `terraform/google/foundation/iam-workload-identity/identity_pool_provider_github.tf` |

### 環境ごとの権限分離

- dry-run 用 SA: `fun-dotto/server` の任意のワークフローから借用可（読み取り専用のため）。
- 適用用 SA: `attribute.repository_environment` が `fun-dotto/server/{dev,stg,prd}` のジョブのみ借用可。PR の dry-run ジョブは Environment を指定しないので借用できない。`prd` は GitHub Environment 側の承認者必須・保護ブランチ限定で守る。

## 手動で実施する SQL（Terraform の管理外）

各 DB（`dotto` / `dotto_stg` / `dotto_dev`）で、`dotto_admin` 権限で 1 回実行する。dev → stg → prd の順。

### 1. dry-run 用の読み取り専用ロール

ロール自体はインスタンス共通なので 1 回だけ作成し、DB ごとに権限を付与する。

```sql
-- 1 回だけ
CREATE ROLE dotto_migrate_readonly NOLOGIN;
GRANT dotto_migrate_readonly TO "gha-server-migrate-dry-run@swift2023groupc.iam";

-- 各 DB で実行
GRANT CONNECT ON DATABASE dotto TO dotto_migrate_readonly;  -- DB 名は環境ごとに読み替える
GRANT USAGE ON SCHEMA public TO dotto_migrate_readonly;
GRANT SELECT ON TABLE public.atlas_schema_revisions TO dotto_migrate_readonly;
```

### 2. 適用用 SA の `SET ROLE` と、新規テーブルへの自動権限付与

```sql
-- 適用用 SA が dotto_admin に SET ROLE できること（PostgreSQL 16+）
GRANT dotto_admin TO "gha-server-migrate-apply@swift2023groupc.iam" WITH INHERIT TRUE, SET TRUE;

-- 各 DB で 1 回: dotto_admin が作るテーブルに dotto_service / dotto_developer の権限を自動付与
ALTER DEFAULT PRIVILEGES FOR ROLE dotto_admin
  GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO dotto_service, dotto_developer;
```

`serial` / `bigserial` を使うテーブルがある場合は、シーケンスの `USAGE` も同様に `ALTER DEFAULT PRIVILEGES ... ON SEQUENCES` で付与する。

### 3. 既存テーブルの owner / 権限

現行の `apply-table-privileges` と同じ内容を各 DB で手動実施する（owner を `dotto_admin` に変更、`dotto_admin` に `ALL`、`dotto_service` / `dotto_developer` に `SELECT, INSERT, UPDATE, DELETE`）。

## 未対応（ワークフロー導入後に実施）

- `terraform/github/fun-dotto/repository-server.tf` の `required_status_checks` に `migrate.yml` のチェック名を追加する。先に追加すると、まだ存在しないチェックを待ってマージ不能になるため、`fun-dotto/server` 側のワークフローが main に入ってから行う。
- 既存の `migrate` / `apply-table-privileges` Cloud Run Job（Terraform 管理外）の実在確認と削除。
