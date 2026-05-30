resource "google_service_account" "scheduler_dev" {
  account_id   = "scheduler-dev"
  display_name = "Cloud Scheduler invoker-dev"
  project      = "swift2023groupc"
}
# terraform import google_service_account.scheduler_dev projects/swift2023groupc/serviceAccounts/scheduler-dev@swift2023groupc.iam.gserviceaccount.com
