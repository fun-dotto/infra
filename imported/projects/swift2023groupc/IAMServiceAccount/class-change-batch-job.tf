resource "google_service_account" "class_change_batch_job" {
  account_id   = "class-change-batch-job"
  display_name = "Class Change Batch Cloud Run Job"
  project      = "swift2023groupc"
}
# terraform import google_service_account.class_change_batch_job projects/swift2023groupc/serviceAccounts/class-change-batch-job@swift2023groupc.iam.gserviceaccount.com
