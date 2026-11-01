output "cloud_run_service_name" {
  description = "The name of the Cloud Run service."
  value       = google_cloud_run_v2_service.this.name
}

output "cloud_run_service_uri" {
  description = "The URI of the Cloud Run service."
  value       = google_cloud_run_v2_service.this.uri
}

output "cloud_run_service_id" {
  description = "The full resource ID of the Cloud Run service."
  value       = google_cloud_run_v2_service.this.id
}

output "service_account_email" {
  description = "The email of the service account used by the Cloud Run service."
  value       = google_service_account.this.email
}

output "service_account_name" {
  description = "The full resource name of the service account used by the Cloud Run service."
  value       = google_service_account.this.name
}
