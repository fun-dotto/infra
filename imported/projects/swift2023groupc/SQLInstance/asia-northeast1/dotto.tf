resource "google_sql_database_instance" "dotto" {
  database_version    = "POSTGRES_18"
  instance_type       = "CLOUD_SQL_INSTANCE"
  maintenance_version = "POSTGRES_18_3.R20260319.00_02"
  name                = "dotto"
  project             = "swift2023groupc"
  region              = "asia-northeast1"

  settings {
    activation_policy = "ALWAYS"
    availability_type = "ZONAL"

    backup_configuration {
      backup_retention_settings {
        retained_backups = 7
        retention_unit   = "COUNT"
      }

      enabled                        = true
      start_time                     = "17:00"
      transaction_log_retention_days = 7
    }

    connector_enforcement = "NOT_REQUIRED"

    database_flags {
      name  = "max_connections"
      value = "100"
    }

    database_flags {
      name  = "cloudsql.iam_authentication"
      value = "on"
    }

    deletion_protection_enabled = true
    disk_autoresize             = false
    disk_autoresize_limit       = 0
    disk_size                   = 10
    disk_type                   = "PD_SSD"
    edition                     = "ENTERPRISE"

    insights_config {
      query_insights_enabled = true
      query_plans_per_minute = 5
      query_string_length    = 1024
    }

    ip_configuration {
      ipv4_enabled = true
      require_ssl  = true
    }

    location_preference {
      zone = "asia-northeast1-b"
    }

    maintenance_window {
      day  = 5
      hour = 18
    }

    password_validation_policy {
      complexity                  = "COMPLEXITY_DEFAULT"
      disallow_username_substring = true
      enable_password_policy      = true
      min_length                  = 8
    }

    pricing_plan = "PER_USE"
    tier         = "db-f1-micro"

    user_labels = {
      managed-by-cnrm = "true"
    }
  }
}
# terraform import google_sql_database_instance.dotto projects/swift2023groupc/instances/dotto
