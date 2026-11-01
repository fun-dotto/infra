# 既存の Access アプリケーション（Storybook、Server Docs など）でも使っている再利用ポリシー
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

# admin-web のサーバーが admin-api を Access 経由で呼ぶための Service Token
resource "cloudflare_zero_trust_access_service_token" "admin_web" {
  for_each = toset(var.environments)

  account_id = data.cloudflare_zone.default.account.id
  name       = "Admin Web (${each.key})"
  # 失効すると admin-web から admin-api を呼べなくなるため、期限を設けない
  duration = "forever"
}

resource "cloudflare_zero_trust_access_policy" "admin_web_service_token" {
  for_each = toset(var.environments)

  account_id = data.cloudflare_zone.default.account.id
  name       = "Admin Web Service Token (${each.key})"
  decision   = "non_identity"

  include = [
    {
      service_token = {
        token_id = cloudflare_zero_trust_access_service_token.admin_web[each.key].id
      }
    },
  ]
}

resource "cloudflare_zero_trust_access_application" "default" {
  for_each = local.access_services

  account_id = data.cloudflare_zone.default.account.id
  name       = each.value.display_name
  type       = "self_hosted"

  destinations = [
    {
      type = "public"
      uri  = each.value.hostname
    },
  ]

  # 開発用モバイル端末は WARP クライアントで Zero Trust に登録して通す
  allow_authenticate_via_warp = true
  app_launcher_visible        = each.value.app_launcher_visible
  # App Launcher のアイコンには各環境の favicon を使う
  logo_url                    = each.value.app_launcher_visible ? "https://${each.value.hostname}/favicon.ico" : null
  session_duration            = "24h"

  policies = concat(
    [
      {
        id         = cloudflare_zero_trust_access_policy.github_members.id
        precedence = 1
      },
    ],
    each.value.name == "admin_api" ? [
      {
        id         = cloudflare_zero_trust_access_policy.admin_web_service_token[each.value.environment].id
        precedence = 2
      },
    ] : [],
  )
}

resource "cloudflare_zero_trust_access_application" "bookmark" {
  for_each = local.bookmark_services

  account_id = data.cloudflare_zone.default.account.id
  name       = each.value.display_name
  type       = "bookmark"
  domain     = each.value.hostname

  app_launcher_visible = true
  logo_url             = "https://${each.value.hostname}/favicon.ico"
}
