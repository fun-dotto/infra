data "google_project" "default" {}

data "terraform_remote_state" "network" {
  backend = "gcs"

  config = {
    bucket = "swift2023groupc-tfstate"
    prefix = "network"
  }
}

data "terraform_remote_state" "cloudflare" {
  backend = "gcs"

  config = {
    bucket = "swift2023groupc-tfstate"
    prefix = "cloudflare"
  }
}

data "terraform_remote_state" "app_bff_api" {
  backend = "gcs"

  config = {
    bucket = "swift2023groupc-tfstate"
    prefix = "server/app-bff-api-dev"
  }
}
