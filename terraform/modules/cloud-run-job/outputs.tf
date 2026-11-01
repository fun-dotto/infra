output "cloud_run_job_name" {
  description = "The name of the Cloud Run job."
  value       = google_cloud_run_v2_job.this.name
}

output "cloud_run_job_id" {
  description = "The full resource ID of the Cloud Run job."
  value       = google_cloud_run_v2_job.this.id
}

output "service_account_email" {
  description = "The email of the service account used by the Cloud Run job."
  value       = google_service_account.this.email
}

output "service_account_name" {
  description = "The full resource name of the service account used by the Cloud Run job."
  value       = google_service_account.this.name
}
