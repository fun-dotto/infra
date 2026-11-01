output "cloud_run_job_name" {
  description = "The name of the Import GTFS Job Cloud Run job."
  value       = google_cloud_run_v2_job.import_gtfs_job.name
}

output "cloud_run_job_id" {
  description = "The full resource ID of the Import GTFS Job Cloud Run job."
  value       = google_cloud_run_v2_job.import_gtfs_job.id
}

output "service_account_email" {
  description = "The email of the job account used by Import GTFS Job."
  value       = google_service_account.import_gtfs_job.email
}

output "service_account_name" {
  description = "The full resource name of the job account used by Import GTFS Job."
  value       = google_service_account.import_gtfs_job.name
}
