# Tunnel を通さないサービスは CNAME で run.app に直接向けるため、Cloud Run がサービスを振り分けられるよう Host ヘッダーを書き換える
resource "cloudflare_ruleset" "origin" {
  zone_id = data.cloudflare_zone.default.id
  name    = "Origin Rules"
  kind    = "zone"
  phase   = "http_request_origin"

  rules = [
    for k, v in local.direct_services : {
      description = k
      expression  = "(http.host eq \"${v.hostname}\")"
      action      = "route"
      action_parameters = {
        host_header = v.origin_host
      }
      enabled = true
    }
  ]
}
