resource "google_service_account" "firebase_app_distribution" {
  account_id   = "firebase-app-distribution"
  description  = "Firebase App Distribution"
  display_name = "Firebase App Distribution"
}
