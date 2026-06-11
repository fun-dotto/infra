resource "google_secret_manager_secret" "app_dart_define_development" {
  secret_id = "app_dart_define_development"

  replication {
    auto {}
  }
}
