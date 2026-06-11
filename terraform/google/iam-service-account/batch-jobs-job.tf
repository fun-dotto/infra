resource "google_service_account" "batch_jobs_job" {
  account_id   = "batch-jobs-job"
  display_name = "Batch Jobs (Go) Cloud Run Job"
}
