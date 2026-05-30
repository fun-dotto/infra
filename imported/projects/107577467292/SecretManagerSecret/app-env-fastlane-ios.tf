resource "google_secret_manager_secret" "app_env_fastlane_ios" {
  labels = {
    managed-by-cnrm = "true"
  }

  project   = "107577467292"
  secret_id = "app_env_fastlane_ios"
}
# terraform import google_secret_manager_secret.app_env_fastlane_ios projects/107577467292/secrets/app_env_fastlane_ios
