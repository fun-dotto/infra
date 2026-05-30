resource "google_service_account" "class_change_batch_scheduler" {
  account_id   = "class-change-batch-scheduler"
  display_name = "Class Change Batch Cloud Scheduler"
  project      = "swift2023groupc"
}
# terraform import google_service_account.class_change_batch_scheduler projects/swift2023groupc/serviceAccounts/class-change-batch-scheduler@swift2023groupc.iam.gserviceaccount.com
