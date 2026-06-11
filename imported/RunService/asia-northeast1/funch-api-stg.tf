resource "google_cloud_run_v2_service" "funch_api_stg" {
  client         = "gcloud"
  client_version = "564.0.0"
  ingress        = "INGRESS_TRAFFIC_ALL"

  labels = {
    commit-sha      = "5ba0eeb98250f44a40be9053d92260c1b534e451"
    managed-by      = "github-actions"
    managed-by-cnrm = "true"
  }

  launch_stage = "GA"
  location     = "asia-northeast1"
  name         = "funch-api-stg"
  project      = "swift2023groupc"

  template {
    containers {
      env {
        name  = "DB_IAM_USER"
        value = "107577467292-compute@developer"
      }

      env {
        name  = "DB_NAME"
        value = "dotto_stg"
      }

      env {
        name  = "INSTANCE_CONNECTION_NAME"
        value = "swift2023groupc:asia-northeast1:dotto"
      }

      image = "asia-northeast1-docker.pkg.dev/swift2023groupc/github-actions/funch-api/funch-api-stg:5ba0eeb98250f44a40be9053d92260c1b534e451"

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
      commit-sha = "5ba0eeb98250f44a40be9053d92260c1b534e451"
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
}
# terraform import google_cloud_run_v2_service.funch_api_stg projects/swift2023groupc/locations/asia-northeast1/services/funch-api-stg
