# TODO: もっとマシな方法を考える

locals {
  environment = endswith(var.service_name, "-dev") ? "dev" : endswith(var.service_name, "-stg") ? "stg" : "prd"

  server_state_prefixes = {
    dev = {
      academic_service     = "server/academic-service-dev"
      announcement_service = "server/announcement-service-dev"
      funch_service        = "server/funch-service-dev"
      user_service         = "server/user-service-dev"
    }
    stg = {
      academic_service     = "server/academic-service-stg"
      announcement_service = "server/announcement-service-stg"
      funch_service        = "server/funch-service-stg"
      user_service         = "server/user-service-stg"
    }
    prd = {
      academic_service     = "server/academic-service-prd"
      announcement_service = "server/announcement-service-prd"
      funch_service        = "server/funch-service-prd"
      user_service         = "server/user-service-prd"
    }
  }
}

data "terraform_remote_state" "academic_service" {
  backend = "gcs"

  config = {
    bucket = var.tfstate_bucket
    prefix = local.server_state_prefixes[local.environment].academic_service
  }
}

data "terraform_remote_state" "announcement_service" {
  backend = "gcs"

  config = {
    bucket = var.tfstate_bucket
    prefix = local.server_state_prefixes[local.environment].announcement_service
  }
}

data "terraform_remote_state" "funch_service" {
  backend = "gcs"

  config = {
    bucket = var.tfstate_bucket
    prefix = local.server_state_prefixes[local.environment].funch_service
  }
}

data "terraform_remote_state" "user_service" {
  backend = "gcs"

  config = {
    bucket = var.tfstate_bucket
    prefix = local.server_state_prefixes[local.environment].user_service
  }
}
