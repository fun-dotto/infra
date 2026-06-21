output "cloud_run_job_name" {
  description = "The name of the Notify User Job Cloud Run job."
  value       = google_cloud_run_v2_job.notify_user_job.name
}

output "cloud_run_job_id" {
  description = "The full resource ID of the Notify User Job Cloud Run job."
  value       = google_cloud_run_v2_job.notify_user_job.id
}

output "service_account_email" {
  description = "The email of the job account used by Notify User Job."
  value       = google_service_account.notify_user_job.email
}

output "service_account_name" {
  description = "The full resource name of the job account used by Notify User Job."
  value       = google_service_account.notify_user_job.name
}
