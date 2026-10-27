# Terraform 管理前から存在する Access アプリケーション

resource "cloudflare_zero_trust_access_application" "app_launcher" {
  account_id = data.cloudflare_zone.default.account.id
  name       = "App Launcher"
  type       = "app_launcher"

  auto_redirect_to_identity    = false
  session_duration             = "24h"
  skip_app_launcher_login_page = false

  landing_page_design = {
    title = "ようこそ、Dotto Accessへ！"
  }

  policies = [
    {
      id         = cloudflare_zero_trust_access_policy.github_members.id
      precedence = 1
    },
  ]
}

resource "cloudflare_zero_trust_access_application" "warp_login" {
  account_id = data.cloudflare_zone.default.account.id
  name       = "Warp Login App"
  type       = "warp"

  auto_redirect_to_identity = false
  session_duration          = "24h"

  policies = [
    {
      id         = cloudflare_zero_trust_access_policy.github_members.id
      precedence = 1
    },
  ]
}

resource "cloudflare_zero_trust_access_application" "web_storybook" {
  account_id = data.cloudflare_zone.default.account.id
  name       = "Web Storybook"
  type       = "self_hosted"

  destinations = [
    {
      type = "public"
      uri  = "dotto-web-storybook.pages.dev"
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

resource "cloudflare_zero_trust_access_application" "server_docs" {
  account_id = data.cloudflare_zone.default.account.id
  name       = "Server Docs"
  type       = "self_hosted"

  destinations = [
    {
      type = "public"
      uri  = "fun-dotto-server-docs.pages.dev"
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

# App Launcher に表示するブックマーク

resource "cloudflare_zero_trust_access_application" "bookmark_dotto_report" {
  account_id           = data.cloudflare_zone.default.account.id
  name                 = "Dotto Report"
  type                 = "bookmark"
  domain               = "https://datastudio.google.com/reporting/638767f2-6a09-4a33-9e0a-7dee4acd6184"
  app_launcher_visible = true

  policies = [
    {
      id         = cloudflare_zero_trust_access_policy.github_members.id
      precedence = 1
    },
  ]
}

resource "cloudflare_zero_trust_access_application" "bookmark_github" {
  account_id           = data.cloudflare_zone.default.account.id
  name                 = "GitHub"
  type                 = "bookmark"
  domain               = "https://github.com/fun-dotto"
  app_launcher_visible = true

  policies = [
    {
      id         = cloudflare_zero_trust_access_policy.github_members.id
      precedence = 1
    },
  ]
}
