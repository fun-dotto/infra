resource "google_cloud_run_v2_service" "academic_api_dev" {
  ingress = "INGRESS_TRAFFIC_ALL"

  labels = {
    commit-sha      = "7b874fe417be62dd228bd7460734bb5fd0e4742c"
    managed-by      = "github-actions"
    managed-by-cnrm = "true"
  }

  launch_stage = "GA"
  location     = "asia-northeast1"
  name         = "academic-api-dev"
  project      = "swift2023groupc"

  template {
    containers {
      command = ["/bin/academic-api"]

      dynamic "env" {
        for_each = var.service_envs["academic_api_dev"]
        content {
          name  = env.key
          value = env.value == "" ? null : env.value
        }
      }

      image = "asia-northeast1-docker.pkg.dev/swift2023groupc/server/server:59276d31bc45"

      ports {
        container_port = 8080
        name           = "http1"
      }

      resources {
        limits = {
          cpu    = "1"
          memory = "512Mi"
        }
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

    execution_environment            = "EXECUTION_ENVIRONMENT_GEN2"
    max_instance_request_concurrency = 80

    scaling {
      max_instance_count = 10
    }

    service_account = "academic-api-dev@swift2023groupc.iam.gserviceaccount.com"
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
# terraform import google_cloud_run_v2_service.academic_api_dev projects/swift2023groupc/locations/asia-northeast1/services/academic-api-dev
