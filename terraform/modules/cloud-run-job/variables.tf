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
  type = list(string)
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
