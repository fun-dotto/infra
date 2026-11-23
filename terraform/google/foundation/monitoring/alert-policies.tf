resource "google_monitoring_alert_policy" "cloud_run_job_error_prd" {
  display_name = "Job Error (Prd)"
  combiner     = "OR"
  enabled      = true
  severity     = "CRITICAL"

  conditions {
    display_name = "Log match condition"

    condition_matched_log {
      filter = <<-EOT
        resource.type="cloud_run_job"
        severity>=ERROR
        (
          resource.labels.job_name="build-class-change-notifications-job" OR
          resource.labels.job_name="class-change-batch" OR
          resource.labels.job_name="dispatch-notifications-job"
        )
      EOT
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
