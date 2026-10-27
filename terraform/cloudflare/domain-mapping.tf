# Access をかけないサービスは Tunnel を通さず、Cloud Run のドメインマッピングで直接公開する
# 事前に Terraform 実行アカウントで fun-dotto.com のドメイン所有権を確認しておく必要がある
resource "google_cloud_run_domain_mapping" "default" {
  for_each = local.direct_services

  location = var.google_cloud_region
  name     = each.value.hostname

  metadata {
    namespace = var.google_cloud_project_id
  }

  spec {
    route_name = each.value.cloud_run_service
  }
}

locals {
  # ドメインマッピングが返すレコードは apply 後にしか分からないため、Cloud Run の固定値を使う
  # https://cloud.google.com/run/docs/mapping-custom-domains
  domain_mapping_records = merge([
    for k, v in local.direct_services : (
      v.hostname == var.cloudflare_zone_name
      ? merge(
        { for ip in ["216.239.32.21", "216.239.34.21", "216.239.36.21", "216.239.38.21"] : "${k}/A/${ip}" => { hostname = v.hostname, type = "A", content = ip } },
        { for ip in ["2001:4860:4802:32::15", "2001:4860:4802:34::15", "2001:4860:4802:36::15", "2001:4860:4802:38::15"] : "${k}/AAAA/${ip}" => { hostname = v.hostname, type = "AAAA", content = ip } },
      )
      : { "${k}/CNAME" = { hostname = v.hostname, type = "CNAME", content = "ghs.googlehosted.com" } }
    )
  ]...)
}

resource "cloudflare_dns_record" "domain_mapping" {
  for_each = local.domain_mapping_records

  zone_id = data.cloudflare_zone.default.id
  name    = each.value.hostname
  type    = each.value.type
  content = each.value.content
  # Cloudflare プロキシを通すと Google のマネージド証明書の発行・更新が通らないため DNS のみにする
  proxied = false
  ttl     = 1

  depends_on = [google_cloud_run_domain_mapping.default]
}
