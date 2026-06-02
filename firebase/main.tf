terraform {
  required_providers {
    google-beta = {
      source  = "hashicorp/google-beta"
      version = "~> 6.0"
    }
  }
}

variable "project_id" {}

variable "name" {}

variable "billing_account" {}

resource "google_project" "default" {
  provider        = google-beta
  project_id      = var.project_id
  name            = var.name
  billing_account = var.billing_account

  lifecycle {
    prevent_destroy = true
  }
}

resource "google_firebase_project" "default" {
  provider = google-beta
  project  = google_project.default.project_id

  lifecycle {
    prevent_destroy = true
  }
}
