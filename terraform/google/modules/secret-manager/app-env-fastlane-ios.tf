resource "google_secret_manager_secret" "app_env_fastlane_ios" {
  secret_id = "app_env_fastlane_ios"

  replication {
    auto {}
  }
}
