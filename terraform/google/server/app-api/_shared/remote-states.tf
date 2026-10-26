# TODO: もっとマシな方法を考える

locals {
  environment = endswith(var.service_name, "-dev") ? "dev" : endswith(var.service_name, "-stg") ? "stg" : "prd"

  web_state_prefix = local.environment == "prd" ? "web/web" : "web/web-${local.environment}"
}

data "terraform_remote_state" "web" {
  backend = "gcs"

  config = {
    bucket = var.tfstate_bucket
    prefix = local.web_state_prefix
  }
}

data "terraform_remote_state" "cloudflare" {
  backend = "gcs"

  config = {
    bucket = var.tfstate_bucket
    prefix = "cloudflare"
  }
}
