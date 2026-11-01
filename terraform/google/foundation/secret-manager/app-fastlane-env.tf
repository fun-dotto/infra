resource "google_secret_manager_secret" "app_fastlane_env" {
  secret_id = "app_fastlane_env"

  replication {
    auto {}
  }
}
