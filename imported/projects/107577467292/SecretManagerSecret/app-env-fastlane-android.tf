resource "google_secret_manager_secret" "app_env_fastlane_android" {
  labels = {
    managed-by-cnrm = "true"
  }

  project   = "107577467292"
  secret_id = "app_env_fastlane_android"
}
# terraform import google_secret_manager_secret.app_env_fastlane_android projects/107577467292/secrets/app_env_fastlane_android
