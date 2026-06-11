resource "google_cloud_run_v2_service" "admin_bff_api" {
  client         = "gcloud"
  client_version = "564.0.0"
  ingress        = "INGRESS_TRAFFIC_ALL"

  labels = {
    commit-sha      = "c5273f6edd5a24b104dae1cbca05362d8b1cf85c"
    managed-by      = "github-actions"
    managed-by-cnrm = "true"
  }

  launch_stage = "GA"
  location     = "asia-northeast1"
  name         = "admin-bff-api"
  project      = "swift2023groupc"

  template {
    containers {
      env {
        name  = "ACADEMIC_API_URL"
        value = "https://academic-api-107577467292.asia-northeast1.run.app"
      }

      env {
        name  = "ANNOUNCEMENT_API_URL"
        value = "https://announcement-api-107577467292.asia-northeast1.run.app"
      }

      env {
        name  = "FUNCH_API_URL"
        value = "https://funch-api-107577467292.asia-northeast1.run.app"
      }

      env {
        name  = "USER_API_URL"
        value = "https://user-api-107577467292.asia-northeast1.run.app"
      }

      image = "asia-northeast1-docker.pkg.dev/swift2023groupc/github-actions/admin-bff-api/admin-bff-api:c5273f6edd5a24b104dae1cbca05362d8b1cf85c"

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
}
# terraform import google_cloud_run_v2_service.admin_bff_api projects/swift2023groupc/locations/asia-northeast1/services/admin-bff-api
