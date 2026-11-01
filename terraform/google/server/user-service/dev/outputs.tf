output "cloud_run_service_name" {
  description = "The name of the User Service Cloud Run service."
  value       = module.service.cloud_run_service_name
}

output "cloud_run_service_uri" {
  description = "The URI of the User Service Cloud Run service."
  value       = module.service.cloud_run_service_uri
}

output "cloud_run_service_id" {
  description = "The full resource ID of the User Service Cloud Run service."
  value       = module.service.cloud_run_service_id
}

output "service_account_email" {
  description = "The email of the service account used by User Service."
  value       = module.service.service_account_email
}

output "service_account_name" {
  description = "The full resource name of the service account used by User Service."
  value       = module.service.service_account_name
}
