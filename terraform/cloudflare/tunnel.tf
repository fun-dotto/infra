resource "cloudflare_zero_trust_tunnel_cloudflared" "default" {
  account_id = data.cloudflare_zone.default.account.id
  name       = "dotto"
  config_src = "cloudflare"
}

data "cloudflare_zero_trust_tunnel_cloudflared_token" "default" {
  account_id = data.cloudflare_zone.default.account.id
  tunnel_id  = cloudflare_zero_trust_tunnel_cloudflared.default.id
}

resource "cloudflare_zero_trust_tunnel_cloudflared_config" "default" {
  account_id = data.cloudflare_zone.default.account.id
  tunnel_id  = cloudflare_zero_trust_tunnel_cloudflared.default.id

  config = {
    ingress = concat(
      [
        # Access をかけるサービスのみ Tunnel 経由にする
        for k, v in local.access_services : {
          hostname = v.hostname
          service  = "https://${v.origin_host}"
          # Cloud Run は Host ヘッダーでサービスを振り分けるため run.app のホスト名に書き換える
          origin_request = {
            http_host_header   = v.origin_host
            origin_server_name = v.origin_host
          }
        }
      ],
      [
        {
          service = "http_status:404"
        },
      ],
    )
  }

  # 経路を先に作ると Access なしで公開されるため、Access アプリケーションの作成を待つ
  depends_on = [cloudflare_zero_trust_access_application.default]
}

resource "cloudflare_dns_record" "default" {
  for_each = local.services

  zone_id = data.cloudflare_zone.default.id
  name    = each.value.hostname
  type    = "CNAME"
  # Access をかけないサービスは run.app に直接向ける（Host ヘッダーは origin-rules.tf で書き換える）
  content = each.value.access ? "${cloudflare_zero_trust_tunnel_cloudflared.default.id}.cfargotunnel.com" : each.value.origin_host
  proxied = true
  ttl     = 1

  depends_on = [cloudflare_zero_trust_access_application.default]
}
