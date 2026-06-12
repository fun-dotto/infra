resource "google_secret_manager_secret" "app_env_fastlane_android" {
  secret_id = "app_env_fastlane_android"

  replication {
    auto {}
  }
}
