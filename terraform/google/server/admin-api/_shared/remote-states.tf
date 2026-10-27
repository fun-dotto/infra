locals {
  environment = endswith(var.service_name, "-dev") ? "dev" : endswith(var.service_name, "-stg") ? "stg" : "prd"
}

data "terraform_remote_state" "cloudflare" {
  backend = "gcs"

  config = {
    bucket = var.tfstate_bucket
    prefix = "cloudflare"
  }
}
