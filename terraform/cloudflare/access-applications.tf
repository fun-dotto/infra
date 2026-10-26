# Terraform 管理前から存在する Access アプリケーション

import {
  to = cloudflare_zero_trust_access_application.app_launcher
  id = "accounts/7d5470511ab2e965d404ee16e47831c1/bbdbe598-2bc7-4d3b-8d84-aeef966ae7d6"
}

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

import {
  to = cloudflare_zero_trust_access_application.warp_login
  id = "accounts/7d5470511ab2e965d404ee16e47831c1/867b0b02-1f9b-4f69-aa1c-95c263af552c"
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

import {
  to = cloudflare_zero_trust_access_application.web_storybook
  id = "accounts/7d5470511ab2e965d404ee16e47831c1/17573825-c795-4d79-945d-9e90561e82e6"
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

import {
  to = cloudflare_zero_trust_access_application.server_docs
  id = "accounts/7d5470511ab2e965d404ee16e47831c1/057aca26-6bd9-4e19-b907-623fc08225d2"
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

import {
  to = cloudflare_zero_trust_access_application.bookmark_dotto_admin
  id = "accounts/7d5470511ab2e965d404ee16e47831c1/345856e2-512c-4d64-9a5a-2b44583c4867"
}

resource "cloudflare_zero_trust_access_application" "bookmark_dotto_admin" {
  account_id           = data.cloudflare_zone.default.account.id
  name                 = "Dotto Admin"
  type                 = "bookmark"
  domain               = "https://admin.dotto.furari.co"
  app_launcher_visible = true

  policies = [
    {
      id         = cloudflare_zero_trust_access_policy.github_members.id
      precedence = 1
    },
  ]
}

import {
  to = cloudflare_zero_trust_access_application.bookmark_dotto_report
  id = "accounts/7d5470511ab2e965d404ee16e47831c1/792ee84c-94e3-497e-a1e1-7700050a9fb9"
}

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

import {
  to = cloudflare_zero_trust_access_application.bookmark_github
  id = "accounts/7d5470511ab2e965d404ee16e47831c1/31364e87-62bb-4fb0-81ab-fec96d075931"
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
