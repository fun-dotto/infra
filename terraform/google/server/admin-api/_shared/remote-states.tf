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

# TODO: 仮で BFF のバイナリを動かすためだけに必要。統合後の API には不要なので削除する
locals {
  server_state_prefixes = {
    for env in ["dev", "stg", "prd"] : env => {
      academic_service     = "server/academic-service-${env}"
      announcement_service = "server/announcement-service-${env}"
      user_service         = "server/user-service-${env}"
    }
  }
}

# TODO: 仮で BFF のバイナリを動かすためだけに必要。統合後の API には不要なので削除する
data "terraform_remote_state" "academic_service" {
  backend = "gcs"

  config = {
    bucket = var.tfstate_bucket
    prefix = local.server_state_prefixes[local.environment].academic_service
  }
}

# TODO: 仮で BFF のバイナリを動かすためだけに必要。統合後の API には不要なので削除する
data "terraform_remote_state" "announcement_service" {
  backend = "gcs"

  config = {
    bucket = var.tfstate_bucket
    prefix = local.server_state_prefixes[local.environment].announcement_service
  }
}

# TODO: 仮で BFF のバイナリを動かすためだけに必要。統合後の API には不要なので削除する
data "terraform_remote_state" "user_service" {
  backend = "gcs"

  config = {
    bucket = var.tfstate_bucket
    prefix = local.server_state_prefixes[local.environment].user_service
  }
}
