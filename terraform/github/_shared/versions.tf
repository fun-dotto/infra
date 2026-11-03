terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "6.12.1"
    }
    google = {
      source  = "hashicorp/google"
      version = "7.34.0"
    }
  }
}
