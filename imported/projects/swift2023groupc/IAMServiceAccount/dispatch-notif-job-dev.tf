resource "google_service_account" "dispatch_notif_job_dev" {
  account_id   = "dispatch-notif-job-dev"
  display_name = "dispatch-notifications-job-dev"
  project      = "swift2023groupc"
}
# terraform import google_service_account.dispatch_notif_job_dev projects/swift2023groupc/serviceAccounts/dispatch-notif-job-dev@swift2023groupc.iam.gserviceaccount.com
