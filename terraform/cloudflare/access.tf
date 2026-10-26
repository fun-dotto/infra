# 既存の Access アプリケーション（Storybook、Server Docs など）でも使っている再利用ポリシー
import {
  to = cloudflare_zero_trust_access_policy.github_members
  id = "7d5470511ab2e965d404ee16e47831c1/d3380222-a79f-49db-95fc-95a3e688c1df"
}

resource "cloudflare_zero_trust_access_policy" "github_members" {
  account_id = data.cloudflare_zone.default.account.id
  name       = "GitHub Members"
  decision   = "allow"

  connection_rules = {
    rdp = {}
  }

  include = [
    {
      github_organization = {
        identity_provider_id = cloudflare_zero_trust_access_identity_provider.github.id
        name                 = "fun-dotto"
        team                 = "Members"
      }
    },
  ]
}

resource "cloudflare_zero_trust_access_application" "default" {
  for_each = local.access_services

  account_id = data.cloudflare_zone.default.account.id
  name       = "dotto-${each.value.environment}-${replace(each.value.name, "_", "-")}"
  type       = "self_hosted"

  destinations = [
    {
      type = "public"
      uri  = each.value.hostname
    },
  ]

  # 開発用モバイル端末は WARP クライアントで Zero Trust に登録して通す
  allow_authenticate_via_warp = true
  app_launcher_visible        = false
  session_duration            = "24h"

  policies = [
    {
      id         = cloudflare_zero_trust_access_policy.github_members.id
      precedence = 1
    },
  ]
}
