resource "cloudflare_zero_trust_access_policy" "members" {
  account_id = data.cloudflare_zone.default.account.id
  name       = "dotto-members"
  decision   = "allow"

  include = concat(
    [for domain in var.access_allowed_email_domains : { email_domain = { domain = domain } }],
    [for email in var.access_allowed_emails : { email = { email = email } }],
  )
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
      id         = cloudflare_zero_trust_access_policy.members.id
      precedence = 1
    },
  ]
}
