# WARP クライアントの Default デバイスプロファイル
# アカウントに 1 つだけ存在する設定で、作成ではなく既存設定の更新として扱われる
resource "cloudflare_zero_trust_device_default_profile" "default" {
  account_id = data.cloudflare_zone.default.account.id

  allow_mode_switch     = false
  allow_updates         = false
  allowed_to_leave      = true
  auto_connect          = 0
  captive_portal        = 180
  disable_auto_fallback = false
  exclude_office_ips    = false
  switch_locked         = false
  tunnel_protocol       = "wireguard"

  service_mode_v2 = {
    mode = "warp"
  }
}
