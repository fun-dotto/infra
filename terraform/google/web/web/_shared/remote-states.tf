locals {
  environment = endswith(var.service_name, "-dev") ? "dev" : endswith(var.service_name, "-stg") ? "stg" : "prd"

  # app-api は本サービスのサービスアカウントを参照するため、remote state ではなく URI を組み立てて循環を避ける
  app_api_service_name = local.environment == "prd" ? "app-api" : "app-api-${local.environment}"
  app_api_url          = "https://${local.app_api_service_name}-${data.google_project.default.number}.${var.google_cloud_region}.run.app"
}

data "google_project" "default" {}

data "terraform_remote_state" "network" {
  backend = "gcs"

  config = {
    bucket = var.tfstate_bucket
    prefix = "network"
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
