resource "google_service_account" "academic_api_dev" {
  account_id   = "academic-api-dev"
  display_name = "academic-api-dev"
}

resource "google_service_account" "batch_jobs_job" {
  account_id   = "batch-jobs-job"
  display_name = "Batch Jobs (Go) Cloud Run Job"
}

resource "google_service_account" "class_change_batch_job" {
  account_id   = "class-change-batch-job"
  display_name = "Class Change Batch Cloud Run Job"
}

resource "google_service_account" "class_change_batch_scheduler" {
  account_id   = "class-change-batch-scheduler"
  display_name = "Class Change Batch Cloud Scheduler"
}

resource "google_service_account" "class_change_notif_job_dev" {
  account_id   = "class-change-notif-job-dev"
  display_name = "build-class-change-notifications-job-dev"
}

resource "google_service_account" "dispatch_notif_job_dev" {
  account_id   = "dispatch-notif-job-dev"
  display_name = "dispatch-notifications-job-dev"
}

resource "google_service_account" "fastlane_supply" {
  account_id   = "fastlane-supply"
  display_name = "fastlane-supply"
  description  = "Account used to give fastlane supply access to Google Play Console."
}

resource "google_service_account" "firebase_adminsdk_v653f" {
  account_id   = "firebase-adminsdk-v653f"
  display_name = "firebase-adminsdk"
  description  = "Firebase Admin SDK Service Agent"
}

resource "google_service_account" "firebase_app_distribution" {
  account_id   = "firebase-app-distribution"
  display_name = "Firebase App Distribution"
  description  = "Firebase App Distribution"
}

resource "google_service_account" "functions_get_fun_schedule" {
  account_id   = "functions-get-fun-schedule"
  display_name = "Functions Get FUN Schedule"
}

resource "google_service_account" "github_actions" {
  account_id   = "github-actions"
  display_name = "GitHub Actions"
}

resource "google_service_account" "migrate_job_dev" {
  account_id   = "migrate-job-dev"
  display_name = "migrate-job-dev"
}

resource "google_service_account" "scheduler_dev" {
  account_id   = "scheduler-dev"
  display_name = "Cloud Scheduler invoker-dev"
}
