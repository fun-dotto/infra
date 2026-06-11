resource "google_service_account" "scheduler_dev" {
  account_id   = "scheduler-dev"
  display_name = "Cloud Scheduler invoker-dev"
}

resource "google_service_account_iam_member" "scheduler_dev_token_creator" {
  service_account_id = google_service_account.scheduler_dev.name
  role               = "roles/iam.serviceAccountTokenCreator"
  member             = "serviceAccount:service-107577467292@gcp-sa-cloudscheduler.iam.gserviceaccount.com"
}
