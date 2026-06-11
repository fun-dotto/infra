resource "google_service_account" "class_change_batch_job" {
  account_id   = "class-change-batch-job"
  display_name = "Class Change Batch Cloud Run Job"
}
