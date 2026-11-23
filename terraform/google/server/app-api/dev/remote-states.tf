data "terraform_remote_state" "cloudflare" {
  backend = "gcs"

  config = {
    bucket = "swift2023groupc-tfstate"
    prefix = "cloudflare"
  }
}

data "terraform_remote_state" "project" {
  backend = "gcs"

  config = {
    bucket = "swift2023groupc-tfstate"
    prefix = "project"
  }
}
