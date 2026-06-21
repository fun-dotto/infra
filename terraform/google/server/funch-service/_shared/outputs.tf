output "cloud_run_service_name" {
  description = "The name of the Funch Service Cloud Run service."
  value       = google_cloud_run_v2_service.funch_service.name
}

output "cloud_run_service_uri" {
  description = "The URI of the Funch Service Cloud Run service."
  value       = google_cloud_run_v2_service.funch_service.uri
}

output "cloud_run_service_id" {
  description = "The full resource ID of the Funch Service Cloud Run service."
  value       = google_cloud_run_v2_service.funch_service.id
}

output "service_account_email" {
  description = "The email of the service account used by Funch Service."
  value       = google_service_account.funch_service.email
}

output "service_account_name" {
  description = "The full resource name of the service account used by Funch Service."
  value       = google_service_account.funch_service.name
}
