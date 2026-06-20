variable "service_account_id" {}

variable "service_account_display_name" {}

variable "db_name" {}

variable "instance_connection_name" {
  default = "swift2023groupc:asia-northeast1:dotto"
}

variable "service_name" {}

variable "max_instance_count" {
  type = number
}

variable "min_instance_count" {
  type = number
}
