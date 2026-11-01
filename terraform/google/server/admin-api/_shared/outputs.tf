output "cloud_run_service_name" {
  description = "The name of the Admin API Cloud Run service."
  value       = google_cloud_run_v2_service.admin_api.name
}

output "cloud_run_service_uri" {
  description = "The URI of the Admin API Cloud Run service."
  value       = google_cloud_run_v2_service.admin_api.uri
}

output "cloud_run_service_id" {
  description = "The full resource ID of the Admin API Cloud Run service."
  value       = google_cloud_run_v2_service.admin_api.id
}

output "service_account_email" {
  description = "The email of the service account used by Admin API."
  value       = google_service_account.admin_api.email
}

output "service_account_name" {
  description = "The full resource name of the service account used by Admin API."
  value       = google_service_account.admin_api.name
}
