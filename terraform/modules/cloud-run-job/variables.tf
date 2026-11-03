variable "project_id" {
  type = string
}

variable "location" {
  type = string
}

variable "job_name" {
  type = string
}

variable "service_account_id" {
  type = string
}

variable "service_account_display_name" {
  type = string
}

variable "project_roles" {
  description = "Project roles granted to the service account."
  type        = set(string)
}

variable "command" {
  description = "Defaults to the image's ENTRYPOINT when null."
  type        = list(string)
  default     = null
}

variable "image" {
  type = string
}

variable "deletion_protection" {
  type = bool
}

variable "cloud_sql" {
  description = "Cloud SQL connection settings exposed to the container as environment variables."
  type = object({
    db_name                  = string
    instance_connection_name = string
  })
}

variable "secret_env" {
  description = "Secret Manager secrets exposed to the container as environment variables. Access is granted to the service account."
  type = list(object({
    name      = string
    secret_id = string
  }))
  default = []
}

variable "schedule" {
  type = string
}

variable "timezone" {
  type = string
}

variable "manage_secret_iam" {
  description = "Whether to grant the service account access to the secrets in secret_env. Set false when the secrets live in a project Terraform cannot manage."
  type        = bool
  default     = true
}

variable "max_retries" {
  type    = number
  default = 0
}

variable "scheduler_service_account_id" {
  description = "Defaults to \"<service_account_id>-scheduler\"."
  type        = string
  default     = null
}

variable "scheduler_service_account_display_name" {
  description = "Defaults to \"<service_account_display_name> Scheduler\"."
  type        = string
  default     = null
}

variable "scheduler_description" {
  type    = string
  default = null
}
