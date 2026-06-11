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
    prefix = "secret-manager"
  }
}

provider "google" {
  project = var.google_cloud_project_id
  region  = var.google_cloud_region
}

provider "google-beta" {
  project = var.google_cloud_project_id
  region  = var.google_cloud_region
}
