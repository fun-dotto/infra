resource "google_monitoring_notification_channel" "dotto_server_alert" {
  display_name = "Dotto Server Alert"
  type         = "slack"
  enabled      = true

  labels = {
    channel_name = "#noti-server-alert"
    team         = "Dotto"
  }

  lifecycle {
    # Google Cloud API masks the existing Slack token, so it cannot be
    # reconstructed when importing this notification channel.
    ignore_changes = [
      labels["auth_token"],
      sensitive_labels,
    ]
  }
}
