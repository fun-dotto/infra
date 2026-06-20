resource "google_cloud_run_v2_service" "admin_api" {
  ingress              = "INGRESS_TRAFFIC_ALL"
  invoker_iam_disabled = true

  launch_stage = "GA"
  location     = var.google_cloud_region
  name         = var.service_name

  template {
    execution_environment = null

    containers {
      command = [
        # TODO: 追加する
        # "/bin/admin-bff-api",
      ]

      env {
        name  = "ACADEMIC_API_URL"
        value = data.terraform_remote_state.academic_service.outputs.cloud_run_service_uri
      }
      env {
        name  = "ANNOUNCEMENT_API_URL"
        value = data.terraform_remote_state.announcement_service.outputs.cloud_run_service_uri
      }
      env {
        name  = "FUNCH_API_URL"
        value = data.terraform_remote_state.funch_service.outputs.cloud_run_service_uri
      }
      env {
        name  = "USER_API_URL"
        value = data.terraform_remote_state.user_service.outputs.cloud_run_service_uri
      }

      image = "${var.google_cloud_region}-docker.pkg.dev/${var.google_cloud_project_id}/github-actions/server:latest"

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

    service_account = google_service_account.server_admin_api.email
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
      labels,
      template[0].labels,
      template[0].containers[0].image,
    ]
  }
}
