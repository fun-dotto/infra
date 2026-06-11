resource "google_cloud_run_v2_service" "app_bff_api_dev" {
  client         = "gcloud"
  client_version = "564.0.0"
  ingress        = "INGRESS_TRAFFIC_ALL"

  labels = {
    commit-sha      = "4f2e6590efb3a595e1434c6e91ce1983a0175922"
    managed-by      = "github-actions"
    managed-by-cnrm = "true"
  }

  launch_stage = "GA"
  location     = "asia-northeast1"
  name         = "app-bff-api-dev"
  project      = "swift2023groupc"

  template {
    containers {
      env {
        name  = "ACADEMIC_API_URL"
        value = "https://academic-api-dev-107577467292.asia-northeast1.run.app"
      }

      env {
        name  = "ANNOUNCEMENT_API_URL"
        value = "https://announcement-api-dev-107577467292.asia-northeast1.run.app"
      }

      env {
        name  = "FUNCH_API_URL"
        value = "https://funch-api-dev-107577467292.asia-northeast1.run.app"
      }

      env {
        name  = "USER_API_URL"
        value = "https://user-api-dev-107577467292.asia-northeast1.run.app"
      }

      image = "asia-northeast1-docker.pkg.dev/swift2023groupc/github-actions/app-bff-api/app-bff-api-dev:4f2e6590efb3a595e1434c6e91ce1983a0175922"

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
      commit-sha = "4f2e6590efb3a595e1434c6e91ce1983a0175922"
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
# terraform import google_cloud_run_v2_service.app_bff_api_dev projects/swift2023groupc/locations/asia-northeast1/services/app-bff-api-dev
