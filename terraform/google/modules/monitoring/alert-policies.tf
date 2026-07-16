resource "google_monitoring_alert_policy" "cloud_run_5xx" {
  display_name = "5xx"
  combiner     = "OR"
  enabled      = true
  severity     = "CRITICAL"

  conditions {
    display_name = "Log match condition"

    condition_matched_log {
      filter = "resource.type=\"cloud_run_revision\"\nhttpRequest.status >= 500"
    }
  }

  notification_channels = [
    google_monitoring_notification_channel.dotto_server_alert.name,
  ]

  alert_strategy {
    auto_close           = "604800s"
    notification_prompts = ["OPENED"]

    notification_rate_limit {
      period = "300s"
    }
  }
}
