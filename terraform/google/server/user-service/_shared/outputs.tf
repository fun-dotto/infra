output "cloud_run_service_name" {
  description = "The name of the User Service Cloud Run service."
  value       = google_cloud_run_v2_service.user_service.name
}

output "cloud_run_service_uri" {
  description = "The URI of the User Service Cloud Run service."
  value       = google_cloud_run_v2_service.user_service.uri
}

output "cloud_run_service_id" {
  description = "The full resource ID of the User Service Cloud Run service."
  value       = google_cloud_run_v2_service.user_service.id
}

output "service_account_email" {
  description = "The email of the service account used by User Service."
  value       = google_service_account.user_service.email
}

output "service_account_name" {
  description = "The full resource name of the service account used by User Service."
  value       = google_service_account.user_service.name
}
