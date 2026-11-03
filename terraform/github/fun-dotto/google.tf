# GitHub Actions の Secret の値を Secret Manager から読み取るために使用する
provider "google" {
  billing_project       = var.google_cloud_project_id
  project               = var.google_cloud_project_id
  region                = var.google_cloud_region
  user_project_override = true
}

variable "google_cloud_project_id" {
  default = "swift2023groupc"
}

variable "google_cloud_region" {
  default = "asia-northeast1"
}
