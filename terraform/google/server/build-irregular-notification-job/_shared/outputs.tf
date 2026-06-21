output "cloud_run_job_name" {
  description = "The name of the Build Irregular Notification Job Cloud Run job."
  value       = google_cloud_run_v2_job.build_irregular_notification_job.name
}

output "cloud_run_job_id" {
  description = "The full resource ID of the Build Irregular Notification Job Cloud Run job."
  value       = google_cloud_run_v2_job.build_irregular_notification_job.id
}

output "service_account_email" {
  description = "The email of the job account used by Build Irregular Notification Job."
  value       = google_service_account.build_irregular_notification_job.email
}

output "service_account_name" {
  description = "The full resource name of the job account used by Build Irregular Notification Job."
  value       = google_service_account.build_irregular_notification_job.name
}
