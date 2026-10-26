# TODO: もっとマシな方法を考える

locals {
  environment = endswith(var.service_name, "-dev") ? "dev" : endswith(var.service_name, "-stg") ? "stg" : "prd"

  admin_web_state_prefix = local.environment == "prd" ? "web/admin-web" : "web/admin-web-${local.environment}"
}

data "terraform_remote_state" "admin_web" {
  backend = "gcs"

  config = {
    bucket = var.tfstate_bucket
    prefix = local.admin_web_state_prefix
  }
}

data "terraform_remote_state" "cloudflare" {
  backend = "gcs"

  config = {
    bucket = var.tfstate_bucket
    prefix = "cloudflare"
  }
}
