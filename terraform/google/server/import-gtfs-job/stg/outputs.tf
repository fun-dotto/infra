output "cloud_run_job_name" {
  description = "The name of the Import GTFS Job Cloud Run job."
  value       = module.job.cloud_run_job_name
}

output "cloud_run_job_id" {
  description = "The full resource ID of the Import GTFS Job Cloud Run job."
  value       = module.job.cloud_run_job_id
}

output "service_account_email" {
  description = "The email of the job account used by Import GTFS Job."
  value       = module.job.service_account_email
}

output "service_account_name" {
  description = "The full resource name of the job account used by Import GTFS Job."
  value       = module.job.service_account_name
}
