resource "google_secret_manager_secret" "app_dart_define_dev" {
  secret_id = "app_dart_define_dev"

  replication {
    auto {}
  }
}

resource "google_secret_manager_secret_iam_member" "app_dart_define_dev" {
  for_each = local.app_secret_accessor_members

  secret_id = google_secret_manager_secret.app_dart_define_dev.secret_id
  role      = "roles/secretmanager.secretAccessor"
  member    = each.value
}
