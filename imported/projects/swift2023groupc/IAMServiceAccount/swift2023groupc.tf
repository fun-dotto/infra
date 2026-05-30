resource "google_service_account" "swift2023groupc" {
  account_id   = "swift2023groupc"
  display_name = "App Engine default service account"
  project      = "swift2023groupc"
}
# terraform import google_service_account.swift2023groupc projects/swift2023groupc/serviceAccounts/swift2023groupc@swift2023groupc.iam.gserviceaccount.com
