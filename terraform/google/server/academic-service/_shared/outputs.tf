output "cloud_run_service_name" {
  description = "The name of the Academic Service Cloud Run service."
  value       = google_cloud_run_v2_service.academic_service.name
}

output "cloud_run_service_uri" {
  description = "The URI of the Academic Service Cloud Run service."
  value       = google_cloud_run_v2_service.academic_service.uri
}

output "cloud_run_service_id" {
  description = "The full resource ID of the Academic Service Cloud Run service."
  value       = google_cloud_run_v2_service.academic_service.id
}

output "service_account_email" {
  description = "The email of the service account used by Academic Service."
  value       = google_service_account.server_academic_service.email
}

output "service_account_name" {
  description = "The full resource name of the service account used by Academic Service."
  value       = google_service_account.server_academic_service.name
}
