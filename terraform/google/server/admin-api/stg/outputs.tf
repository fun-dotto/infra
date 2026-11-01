output "cloud_run_service_name" {
  description = "The name of the Admin API Cloud Run service."
  value       = module.service.cloud_run_service_name
}

output "cloud_run_service_uri" {
  description = "The URI of the Admin API Cloud Run service."
  value       = module.service.cloud_run_service_uri
}

output "cloud_run_service_id" {
  description = "The full resource ID of the Admin API Cloud Run service."
  value       = module.service.cloud_run_service_id
}

output "service_account_email" {
  description = "The email of the service account used by Admin API."
  value       = module.service.service_account_email
}

output "service_account_name" {
  description = "The full resource name of the service account used by Admin API."
  value       = module.service.service_account_name
}
