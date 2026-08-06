resource "google_monitoring_alert_policy" "cloud_run_service_server_error_prd" {
  display_name = "Service Server Error (Prd)"
  combiner     = "OR"
  enabled      = true
  severity     = "CRITICAL"

  conditions {
    display_name = "Log match condition"

    condition_matched_log {
      filter = <<-EOT
        resource.type="cloud_run_revision"
        severity >= ERROR
        (
          resource.labels.service_name="announcement-api" OR
          resource.labels.service_name="academic-api" OR
          resource.labels.service_name="funch-api" OR
          resource.labels.service_name="user-api"
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

resource "google_monitoring_alert_policy" "cloud_run_api_server_error_prd" {
  display_name = "API Server Error (Prd)"
  combiner     = "OR"
  enabled      = true
  severity     = "CRITICAL"

  conditions {
    display_name = "Log match condition"

    condition_matched_log {
      filter = <<-EOT
        resource.type="cloud_run_revision"
        severity >= ERROR
        (
          resource.labels.service_name="app-bff-api"
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
