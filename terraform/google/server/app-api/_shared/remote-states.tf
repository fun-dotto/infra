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

# cloudflare/ は本サービスの URI を参照するため、初回は Cloudflare 側の apply 前でも plan できるように defaults を置く
data "terraform_remote_state" "cloudflare" {
  backend = "gcs"

  config = {
    bucket = var.tfstate_bucket
    prefix = "cloudflare"
  }

  defaults = {
    access_issuer = ""
    access_auds   = {}
  }
}
