resource "google_service_account" "scheduler_dev" {
  account_id   = "scheduler-dev"
  display_name = "Cloud Scheduler invoker-dev"
}
