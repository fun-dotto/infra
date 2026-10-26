import {
  to = cloudflare_zero_trust_organization.default
  id = "7d5470511ab2e965d404ee16e47831c1"
}

resource "cloudflare_zero_trust_organization" "default" {
  account_id  = data.cloudflare_zone.default.account.id
  name        = "Dotto"
  auth_domain = "fun-dotto.cloudflareaccess.com"

  allow_authenticate_via_warp = true
  deny_unmatched_requests     = false
  is_ui_read_only             = false
  strict_service_token_auth   = false
  warp_auth_non_browser_401   = false
  warp_auth_session_duration  = "8h"

  deny_unmatched_requests_exempted_zone_names = []

  lifecycle {
    # API が返す無効状態の { enabled = false } は action などが必須なため HCL で表現できない
    ignore_changes = [service_token_inactivity]
  }
}

import {
  to = cloudflare_zero_trust_access_identity_provider.github
  id = "accounts/7d5470511ab2e965d404ee16e47831c1/aa9b02c5-2e49-4576-81a5-ac03c5baeb99"
}

resource "cloudflare_zero_trust_access_identity_provider" "github" {
  account_id = data.cloudflare_zone.default.account.id
  name       = "GitHub"
  type       = "github"

  config = {
    client_id     = "Ov23liVkPBj2tnCqk747"
    client_secret = var.github_identity_provider_client_secret
  }
}
