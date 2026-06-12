resource "google_service_account" "class_change_batch_scheduler" {
  account_id   = "class-change-batch-scheduler"
  display_name = "Class Change Batch Cloud Scheduler"
}

resource "google_service_account_iam_member" "class_change_batch_scheduler_token_creator" {
  service_account_id = google_service_account.class_change_batch_scheduler.name
  role               = "roles/iam.serviceAccountTokenCreator"
  member             = "serviceAccount:service-107577467292@gcp-sa-cloudscheduler.iam.gserviceaccount.com"
}
