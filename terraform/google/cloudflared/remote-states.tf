data "terraform_remote_state" "network" {
  backend = "gcs"

  config = {
    bucket = var.tfstate_bucket
    prefix = "network"
  }
}

data "terraform_remote_state" "cloudflare" {
  backend = "gcs"

  config = {
    bucket = var.tfstate_bucket
    prefix = "cloudflare"
  }
}
