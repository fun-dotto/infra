resource "google_sql_user" "service_account" {
  for_each = local.database_service_accounts

  database_roles = ["dotto_service"]
  instance       = google_sql_database_instance.dotto.name
  name           = "${each.value}@${google_sql_database_instance.dotto.project}.iam"
  project        = google_sql_database_instance.dotto.project
  type           = "CLOUD_IAM_SERVICE_ACCOUNT"
}

resource "google_sql_user" "admin" {
  for_each = local.database_admins

  database_roles = ["dotto_admin"]
  instance       = google_sql_database_instance.dotto.name
  name           = each.value
  project        = google_sql_database_instance.dotto.project
  type           = "CLOUD_IAM_USER"
}

resource "google_sql_user" "developer" {
  for_each = local.database_developers

  database_roles = ["dotto_developer"]
  instance       = google_sql_database_instance.dotto.name
  name           = each.value
  project        = google_sql_database_instance.dotto.project
  type           = "CLOUD_IAM_USER"
}

# GitHub Actions (fun-dotto/server) のマイグレーション用 IAM ユーザー。
# SA は terraform/google/foundation/iam-workload-identity で作成する。
# dry-run 用: 読み取り専用。DB ロールは Terraform の管理外のため、手動 SQL で付与する (docs/atlas-migration.md)
resource "google_sql_user" "migrate_dry_run" {
  instance = google_sql_database_instance.dotto.name
  name     = "${local.migrate_dry_run_service_account}@${google_sql_database_instance.dotto.project}.iam"
  project  = google_sql_database_instance.dotto.project
  type     = "CLOUD_IAM_SERVICE_ACCOUNT"
}

# 適用用: dotto_admin のメンバー。接続時に role=dotto_admin を指定して DDL を実行する
resource "google_sql_user" "migrate_apply" {
  database_roles = ["dotto_admin"]
  instance       = google_sql_database_instance.dotto.name
  name           = "${local.migrate_apply_service_account}@${google_sql_database_instance.dotto.project}.iam"
  project        = google_sql_database_instance.dotto.project
  type           = "CLOUD_IAM_SERVICE_ACCOUNT"
}
