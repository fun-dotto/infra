resource "google_service_account" "batch_jobs_job" {
  account_id   = "batch-jobs-job"
  display_name = "Batch Jobs (Go) Cloud Run Job"
  project      = "swift2023groupc"
}
# terraform import google_service_account.batch_jobs_job projects/swift2023groupc/serviceAccounts/batch-jobs-job@swift2023groupc.iam.gserviceaccount.com
