data "google_project" "default" {}

data "terraform_remote_state" "cloudflare" {
  backend = "gcs"

  config = {
    bucket = "swift2023groupc-tfstate"
    prefix = "cloudflare"
  }
}
