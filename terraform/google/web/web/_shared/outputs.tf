output "cloud_run_service_name" {
  description = "The name of the Web Cloud Run service."
  value       = google_cloud_run_v2_service.web.name
}

output "cloud_run_service_uri" {
  description = "The URI of the Web Cloud Run service."
  value       = google_cloud_run_v2_service.web.uri
}

output "cloud_run_service_id" {
  description = "The full resource ID of the Web Cloud Run service."
  value       = google_cloud_run_v2_service.web.id
}

output "service_account_email" {
  description = "The email of the service account used by Web."
  value       = google_service_account.web.email
}

output "service_account_name" {
  description = "The full resource name of the service account used by Web."
  value       = google_service_account.web.name
}
