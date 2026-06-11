terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "7.34.0"
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = "7.34.0"
    }
  }

  backend "gcs" {
    bucket = "swift2023groupc-tfstate"
    prefix = "firebase-remote-config"
  }
}

provider "google" {
  project               = var.google_cloud_project_id
  region                = var.google_cloud_region
  user_project_override = true
  billing_project       = var.google_cloud_project_id
}

provider "google-beta" {
  project               = var.google_cloud_project_id
  region                = var.google_cloud_region
  user_project_override = true
  billing_project       = var.google_cloud_project_id
}
