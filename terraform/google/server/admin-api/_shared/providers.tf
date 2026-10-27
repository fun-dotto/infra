provider "google" {
  billing_project       = var.google_cloud_project_id
  project               = var.google_cloud_project_id
  region                = var.google_cloud_region
  user_project_override = true
}

provider "google-beta" {
  billing_project       = var.google_cloud_project_id
  project               = var.google_cloud_project_id
  region                = var.google_cloud_region
  user_project_override = true
}
