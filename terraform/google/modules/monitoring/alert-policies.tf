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

# 配分は docs/cloud-sql-connections.md を参照
resource "google_monitoring_alert_policy" "cloud_sql_connections_total" {
  display_name = "Cloud SQL Connections High (Total)"
  combiner     = "OR"
  enabled      = true
  severity     = "CRITICAL"

  conditions {
    display_name = "Connections over 80% of max_connections"

    condition_threshold {
      filter = <<-EOT
        resource.type="cloudsql_database"
        resource.labels.database_id="swift2023groupc:dotto"
        metric.type="cloudsql.googleapis.com/database/postgresql/num_backends"
      EOT

      comparison      = "COMPARISON_GT"
      duration        = "300s"
      threshold_value = 80

      aggregations {
        alignment_period     = "60s"
        per_series_aligner   = "ALIGN_MEAN"
        cross_series_reducer = "REDUCE_SUM"
        group_by_fields      = ["resource.label.database_id"]
      }
    }
  }

  notification_channels = [
    google_monitoring_notification_channel.dotto_server_alert.name,
  ]

  alert_strategy {
    auto_close           = "604800s"
    notification_prompts = ["OPENED"]
  }
}

resource "google_monitoring_alert_policy" "cloud_sql_connections_non_prd" {
  display_name = "Cloud SQL Connections Over Budget (Dev/Stg)"
  combiner     = "OR"
  enabled      = true
  severity     = "WARNING"

  conditions {
    display_name = "Connections over the per-environment budget"

    condition_threshold {
      filter = <<-EOT
        resource.type="cloudsql_database"
        resource.labels.database_id="swift2023groupc:dotto"
        metric.type="cloudsql.googleapis.com/database/postgresql/num_backends"
        metric.labels.database=one_of("dotto_dev", "dotto_stg")
      EOT

      comparison      = "COMPARISON_GT"
      duration        = "300s"
      threshold_value = 16

      aggregations {
        alignment_period   = "60s"
        per_series_aligner = "ALIGN_MEAN"
      }
    }
  }

  notification_channels = [
    google_monitoring_notification_channel.dotto_server_alert.name,
  ]

  alert_strategy {
    auto_close           = "604800s"
    notification_prompts = ["OPENED"]
  }
}
