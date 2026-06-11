resource "google_service_account" "class_change_batch_scheduler" {
  account_id   = "class-change-batch-scheduler"
  display_name = "Class Change Batch Cloud Scheduler"
}
