resource "google_cloud_run_v2_service" "user_service" {
  ingress = "INGRESS_TRAFFIC_ALL"

  launch_stage = "GA"
  location     = var.google_cloud_region
  name         = var.service_name

  template {
    execution_environment = null

    containers {
      command = [
        "/bin/user-api",
      ]

      env {
        name  = "DB_IAM_USER"
        value = trimsuffix(google_service_account.user_service.email, ".gserviceaccount.com")
      }
      env {
        name  = "DB_NAME"
        value = var.db_name
      }
      env {
        name  = "INSTANCE_CONNECTION_NAME"
        value = var.instance_connection_name
      }

      image = var.image

      ports {
        container_port = 8080
        name           = "http1"
      }

      resources {
        cpu_idle = true

        limits = {
          cpu    = "1"
          memory = "512Mi"
        }

        startup_cpu_boost = true
      }

      startup_probe {
        failure_threshold     = 1
        initial_delay_seconds = 0
        period_seconds        = 240

        tcp_socket {
          port = 8080
        }

        timeout_seconds = 240
      }
    }

    max_instance_request_concurrency = 80

    scaling {
      max_instance_count = var.max_instance_count
      min_instance_count = var.min_instance_count
    }

    service_account = google_service_account.user_service.email
    timeout         = "300s"
  }

  traffic {
    percent = 100
    type    = "TRAFFIC_TARGET_ALLOCATION_TYPE_LATEST"
  }

  lifecycle {
    ignore_changes = [
      client,
      client_version,
      template[0].labels,
      template[0].containers[0].image,
    ]
  }
}
