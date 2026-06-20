output "cloud_run_service_name" {
  description = "The name of the Announcement Service Cloud Run service."
  value       = google_cloud_run_v2_service.announcement_service.name
}

output "cloud_run_service_uri" {
  description = "The URI of the Announcement Service Cloud Run service."
  value       = google_cloud_run_v2_service.announcement_service.uri
}

output "cloud_run_service_id" {
  description = "The full resource ID of the Announcement Service Cloud Run service."
  value       = google_cloud_run_v2_service.announcement_service.id
}

output "service_account_email" {
  description = "The email of the service account used by Announcement Service."
  value       = google_service_account.server_announcement_service.email
}

output "service_account_name" {
  description = "The full resource name of the service account used by Announcement Service."
  value       = google_service_account.server_announcement_service.name
}
