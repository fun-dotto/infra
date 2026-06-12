resource "google_secret_manager_secret" "app_dart_define_production" {
  secret_id = "app_dart_define_production"

  replication {
    auto {}
  }
}
