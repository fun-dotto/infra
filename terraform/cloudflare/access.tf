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
