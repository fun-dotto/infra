resource "google_cloud_run_v2_service" "user_api" {
  client         = "gcloud"
  client_version = "564.0.0"
  ingress        = "INGRESS_TRAFFIC_ALL"

  labels = {
    commit-sha      = "39378159d90e786c7fd02eb39fc94ffbca411baa"
    managed-by      = "github-actions"
    managed-by-cnrm = "true"
  }

  launch_stage = "GA"
  location     = "asia-northeast1"
  name         = "user-api"
  project      = "swift2023groupc"

  template {
    containers {
      env {
        name  = "DB_IAM_USER"
        value = "107577467292-compute@developer"
      }

      env {
        name  = "DB_NAME"
        value = "dotto"
      }

      env {
        name  = "INSTANCE_CONNECTION_NAME"
        value = "swift2023groupc:asia-northeast1:dotto"
      }

      image = "asia-northeast1-docker.pkg.dev/swift2023groupc/github-actions/user-api/user-api:39378159d90e786c7fd02eb39fc94ffbca411baa"

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
      commit-sha = "39378159d90e786c7fd02eb39fc94ffbca411baa"
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
# terraform import google_cloud_run_v2_service.user_api projects/swift2023groupc/locations/asia-northeast1/services/user-api
