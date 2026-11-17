resource "google_sql_user" "service_account" {
  for_each = local.database_service_account_roles

  database_roles = [each.value]
  instance       = google_sql_database_instance.dotto.name
  name           = "${each.key}@${google_sql_database_instance.dotto.project}.iam"
  project        = google_sql_database_instance.dotto.project
  type           = "CLOUD_IAM_SERVICE_ACCOUNT"
}

resource "google_sql_user" "developer" {
  for_each = local.database_developers

  database_roles = ["dotto_developer"]
  instance       = google_sql_database_instance.dotto.name
  name           = each.value
  project        = google_sql_database_instance.dotto.project
  type           = "CLOUD_IAM_USER"
}

# GitHub Actions (fun-dotto/server) のマイグレーション用 IAM ユーザー。環境ごとに分けている。
# SA は terraform/google/foundation/iam-workload-identity で作成する。
# ロールは先に手動 SQL で作成しておく必要がある (docs/postgresql_roles.md)。
# dry-run 用: 読み取り専用 (dotto_migrate_readonly_<env>)
resource "google_sql_user" "migrate_dry_run" {
  for_each = local.database_migrate_environments

  database_roles = ["dotto_migrate_readonly_${each.key}"]
  instance       = google_sql_database_instance.dotto.name
  name           = "${local.migrate_dry_run_service_account_prefix}-${each.key}@${google_sql_database_instance.dotto.project}.iam"
  project        = google_sql_database_instance.dotto.project
  type           = "CLOUD_IAM_SERVICE_ACCOUNT"
}

# 適用用: dotto_admin_<env> のメンバー。接続時に role=dotto_admin_<env> を指定して DDL を実行する
resource "google_sql_user" "migrate_apply" {
  for_each = local.database_migrate_environments

  database_roles = ["dotto_admin_${each.key}"]
  instance       = google_sql_database_instance.dotto.name
  name           = "${local.migrate_apply_service_account_prefix}-${each.key}@${google_sql_database_instance.dotto.project}.iam"
  project        = google_sql_database_instance.dotto.project
  type           = "CLOUD_IAM_SERVICE_ACCOUNT"
}

# DB 内のロールと権限を Terraform で管理するための terraform-ci の IAM ユーザー。
# Cloud SQL では SUPERUSER を作れないため cloudsqlsuperuser に所属させる。
resource "google_sql_user" "terraform_ci" {
  database_roles = ["cloudsqlsuperuser"]
  instance       = google_sql_database_instance.dotto.name
  name           = "terraform-ci@${google_sql_database_instance.dotto.project}.iam"
  project        = google_sql_database_instance.dotto.project
  type           = "CLOUD_IAM_SERVICE_ACCOUNT"
}

# 旧 google_sql_user.admin (dotto_admin) の 3 名は dotto_developer に統合した。ユーザーを作り直さないよう移動する
moved {
  from = google_sql_user.admin["beretta0602@gmail.com"]
  to   = google_sql_user.developer["beretta0602@gmail.com"]
}

moved {
  from = google_sql_user.admin["iam@kantacky.com"]
  to   = google_sql_user.developer["iam@kantacky.com"]
}

moved {
  from = google_sql_user.admin["msyaaa456910@gmail.com"]
  to   = google_sql_user.developer["msyaaa456910@gmail.com"]
}
