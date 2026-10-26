data "terraform_remote_state" "services" {
  for_each = local.services

  backend = "gcs"

  config = {
    bucket = var.tfstate_bucket
    prefix = each.value.state_prefix
  }
}
