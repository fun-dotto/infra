variable "service_account_id" {}

variable "service_account_display_name" {}

variable "db_name" {}

variable "instance_connection_name" {
  default = "swift2023groupc:asia-northeast1:dotto"
}

variable "service_name" {}

variable "image" {
  default = "asia-northeast1-docker.pkg.dev/swift2023groupc/github-actions/server:latest"
}

variable "schedule" {
  default = "30 17 * * *"
}

variable "timezone" {
  default = "Asia/Tokyo"
}
