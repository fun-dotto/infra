resource "google_service_account" "class_change_notif_job_dev" {
  account_id   = "class-change-notif-job-dev"
  display_name = "build-class-change-notifications-job-dev"
  project      = "swift2023groupc"
}
# terraform import google_service_account.class_change_notif_job_dev projects/swift2023groupc/serviceAccounts/class-change-notif-job-dev@swift2023groupc.iam.gserviceaccount.com
