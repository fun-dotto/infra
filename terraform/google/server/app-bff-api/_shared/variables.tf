variable "service_account_id" {}

variable "service_account_display_name" {}

variable "service_name" {}

variable "tfstate_bucket" {
  default = "swift2023groupc-tfstate"
}

variable "image" {
  default = "asia-northeast1-docker.pkg.dev/swift2023groupc/github-actions/server:latest"
}

variable "max_instance_count" {
  type = number
}

variable "min_instance_count" {
  type = number
}
