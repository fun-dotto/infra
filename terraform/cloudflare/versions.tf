terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "5.28.1"
    }
    google = {
      source  = "hashicorp/google"
      version = "7.34.0"
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = "7.34.0"
    }
  }
}
