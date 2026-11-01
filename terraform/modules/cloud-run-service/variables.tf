variable "project_id" {
  type = string
}

variable "location" {
  type = string
}

variable "service_name" {
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
  type    = list(string)
  default = null
}

variable "image" {
  type = string
}

variable "ingress" {
  type = string
}

variable "invoker_iam_disabled" {
  type    = bool
  default = null
}

variable "default_uri_disabled" {
  type    = bool
  default = null
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
  default = null
}

variable "env" {
  description = "Environment variables exposed to the container, placed before the Cloud SQL settings."
  type = list(object({
    name  = string
    value = string
  }))
  default = []
}

variable "vpc_access" {
  description = "VPC network the service sends egress traffic through."
  type = object({
    egress     = string
    network    = string
    subnetwork = string
  })
  default = null
}

variable "max_instance_count" {
  type = number
}

variable "min_instance_count" {
  type = number
}
