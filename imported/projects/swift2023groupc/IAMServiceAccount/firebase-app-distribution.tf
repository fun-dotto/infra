resource "google_service_account" "firebase_app_distribution" {
  account_id   = "firebase-app-distribution"
  description  = "Firebase App Distribution"
  display_name = "Firebase App Distribution"
  project      = "swift2023groupc"
}
# terraform import google_service_account.firebase_app_distribution projects/swift2023groupc/serviceAccounts/firebase-app-distribution@swift2023groupc.iam.gserviceaccount.com
