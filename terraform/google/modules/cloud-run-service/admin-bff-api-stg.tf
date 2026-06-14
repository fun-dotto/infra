resource "google_cloud_run_v2_service" "admin_bff_api_stg" {
  client               = "gcloud"
  client_version       = "564.0.0"
  ingress              = "INGRESS_TRAFFIC_ALL"
  invoker_iam_disabled = true

  labels = {
    commit-sha      = "c5273f6edd5a24b104dae1cbca05362d8b1cf85c"
    managed-by      = "github-actions"
    managed-by-cnrm = "true"
  }

  launch_stage = "GA"
  location     = "asia-northeast1"
  name         = "admin-bff-api-stg"
  project      = "swift2023groupc"

  template {
    containers {
      dynamic "env" {
        for_each = var.service_envs["admin_bff_api_stg"]
        content {
          name  = env.key
          value = env.value == "" ? null : env.value
        }
      }

      image = "asia-northeast1-docker.pkg.dev/swift2023groupc/github-actions/admin-bff-api/admin-bff-api-stg:c5273f6edd5a24b104dae1cbca05362d8b1cf85c"

      ports {
        container_port = 8080
        name           = "http1"
      }

      resources {
        cpu_idle = true

        limits = {
          cpu    = "1000m"
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

    labels = {
      commit-sha = "c5273f6edd5a24b104dae1cbca05362d8b1cf85c"
      managed-by = "github-actions"
    }

    max_instance_request_concurrency = 80

    scaling {
      max_instance_count = 100
    }

    service_account = "107577467292-compute@developer.gserviceaccount.com"
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
# terraform import google_cloud_run_v2_service.admin_bff_api_stg projects/swift2023groupc/locations/asia-northeast1/services/admin-bff-api-stg
