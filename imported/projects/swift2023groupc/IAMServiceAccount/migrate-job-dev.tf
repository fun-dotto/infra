resource "google_service_account" "migrate_job_dev" {
  account_id   = "migrate-job-dev"
  display_name = "migrate-job-dev"
  project      = "swift2023groupc"
}
# terraform import google_service_account.migrate_job_dev projects/swift2023groupc/serviceAccounts/migrate-job-dev@swift2023groupc.iam.gserviceaccount.com
