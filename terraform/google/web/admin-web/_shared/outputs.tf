output "cloud_run_service_name" {
  description = "The name of the Admin Web Cloud Run service."
  value       = google_cloud_run_v2_service.admin_web.name
}

output "cloud_run_service_uri" {
  description = "The URI of the Admin Web Cloud Run service."
  value       = google_cloud_run_v2_service.admin_web.uri
}

output "cloud_run_service_id" {
  description = "The full resource ID of the Admin Web Cloud Run service."
  value       = google_cloud_run_v2_service.admin_web.id
}

output "service_account_email" {
  description = "The email of the service account used by Admin Web."
  value       = google_service_account.web_admin_web.email
}

output "service_account_name" {
  description = "The full resource name of the service account used by Admin Web."
  value       = google_service_account.web_admin_web.name
}
