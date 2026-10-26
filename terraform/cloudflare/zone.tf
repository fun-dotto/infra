data "cloudflare_zone" "default" {
  filter = {
    name = var.cloudflare_zone_name
  }
}

data "cloudflare_zero_trust_organization" "default" {
  account_id = data.cloudflare_zone.default.account.id
}
