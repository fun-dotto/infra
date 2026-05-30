resource "google_secret_manager_secret" "app_dart_define_development" {
  labels = {
    managed-by-cnrm = "true"
  }

  project   = "107577467292"
  secret_id = "app_dart_define_development"
}
# terraform import google_secret_manager_secret.app_dart_define_development projects/107577467292/secrets/app_dart_define_development
