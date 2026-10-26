resource "cloudflare_zero_trust_tunnel_cloudflared" "default" {
  account_id = data.cloudflare_zone.default.account.id
  name       = "dotto"
  config_src = "cloudflare"
}

data "cloudflare_zero_trust_tunnel_cloudflared_token" "default" {
  account_id = data.cloudflare_zone.default.account.id
  tunnel_id  = cloudflare_zero_trust_tunnel_cloudflared.default.id
}
