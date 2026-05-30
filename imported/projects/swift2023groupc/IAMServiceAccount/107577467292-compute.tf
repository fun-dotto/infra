resource "google_service_account" "107577467292_compute" {
  account_id   = "107577467292-compute"
  display_name = "Default compute service account"
  project      = "swift2023groupc"
}
# terraform import google_service_account.107577467292_compute projects/swift2023groupc/serviceAccounts/107577467292-compute@swift2023groupc.iam.gserviceaccount.com
