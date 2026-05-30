resource "google_service_account" "academic_api_dev" {
  account_id   = "academic-api-dev"
  display_name = "academic-api-dev"
  project      = "swift2023groupc"
}
# terraform import google_service_account.academic_api_dev projects/swift2023groupc/serviceAccounts/academic-api-dev@swift2023groupc.iam.gserviceaccount.com
