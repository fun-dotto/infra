variable "service_account_id" {}

variable "service_account_display_name" {}

variable "service_name" {}

variable "tfstate_bucket" {
  default = "swift2023groupc-tfstate"
}

variable "max_instance_count" {
  type = number
}

variable "min_instance_count" {
  type = number
}
