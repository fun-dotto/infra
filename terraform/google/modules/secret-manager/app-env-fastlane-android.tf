resource "google_secret_manager_secret" "app_env_fastlane_android" {
  secret_id = "app_env_fastlane_android"

  replication {
    auto {}
  }
}

resource "google_secret_manager_secret_iam_member" "app_env_fastlane_android" {
  secret_id = google_secret_manager_secret.app_env_fastlane_android.secret_id
  role      = "roles/secretmanager.secretAccessor"
  member    = local.app_secret_accessor_member
}
