# Cloudflare Tunnel 経由で公開し、App Launcher に表示する Cloud Run サービス

locals {
  cloud_run_apps = {
    admin_web_prd = { name = "Dotto Admin", hostname = "admin", state = "web/admin-web-prd" }
    admin_web_stg = { name = "Dotto Admin (Stg)", hostname = "admin-stg", state = "web/admin-web-stg" }
    admin_web_dev = { name = "Dotto Admin (Dev)", hostname = "admin-dev", state = "web/admin-web-dev" }
    web_prd       = { name = "Dotto Web", hostname = "web", state = "web/web-prd" }
    web_stg       = { name = "Dotto Web (Stg)", hostname = "web-stg", state = "web/web-stg" }
    web_dev       = { name = "Dotto Web (Dev)", hostname = "web-dev", state = "web/web-dev" }
  }
}

data "terraform_remote_state" "cloud_run_app" {
  for_each = local.cloud_run_apps

  backend = "gcs"

  config = {
    bucket = var.tfstate_bucket
    prefix = each.value.state
  }
}

resource "cloudflare_dns_record" "cloud_run_app" {
  for_each = local.cloud_run_apps

  zone_id = data.cloudflare_zone.default.zone_id
  name    = "${each.value.hostname}.${var.cloudflare_zone_name}"
  type    = "CNAME"
  content = "${cloudflare_zero_trust_tunnel_cloudflared.default.id}.cfargotunnel.com"
  proxied = true
  ttl     = 1
}

resource "cloudflare_zero_trust_tunnel_cloudflared_config" "default" {
  account_id = data.cloudflare_zone.default.account.id
  tunnel_id  = cloudflare_zero_trust_tunnel_cloudflared.default.id

  config = {
    ingress = concat(
      [
        for key, app in local.cloud_run_apps : {
          hostname = "${app.hostname}.${var.cloudflare_zone_name}"
          service  = data.terraform_remote_state.cloud_run_app[key].outputs.cloud_run_service_uri
          origin_request = {
            # Cloud Run はホストヘッダでサービスを振り分けるため run.app のホスト名に書き換える
            http_host_header = trimprefix(data.terraform_remote_state.cloud_run_app[key].outputs.cloud_run_service_uri, "https://")
          }
        }
      ],
      [{ service = "http_status:404" }],
    )
  }
}

resource "cloudflare_zero_trust_access_application" "cloud_run_app" {
  for_each = local.cloud_run_apps

  account_id = data.cloudflare_zone.default.account.id
  name       = each.value.name
  type       = "self_hosted"

  destinations = [
    {
      type = "public"
      uri  = "${each.value.hostname}.${var.cloudflare_zone_name}"
    },
  ]

  app_launcher_visible       = true
  auto_redirect_to_identity  = false
  enable_binding_cookie      = false
  http_only_cookie_attribute = false
  options_preflight_bypass   = false
  session_duration           = "24h"

  policies = [
    {
      id         = cloudflare_zero_trust_access_policy.github_members.id
      precedence = 1
    },
  ]
}
