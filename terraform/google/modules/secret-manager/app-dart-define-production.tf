resource "google_secret_manager_secret" "app_dart_define_production" {
  secret_id = "app_dart_define_production"

  replication {
    auto {}
  }
}

resource "google_secret_manager_secret_iam_member" "app_dart_define_production" {
  secret_id = google_secret_manager_secret.app_dart_define_production.secret_id
  role      = "roles/secretmanager.secretAccessor"
  member    = local.app_secret_accessor_member
}
