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
