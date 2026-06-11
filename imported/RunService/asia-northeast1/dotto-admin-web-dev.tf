resource "google_cloud_run_v2_service" "dotto_admin_web_dev" {
  client         = "gcloud"
  client_version = "564.0.0"
  ingress        = "INGRESS_TRAFFIC_ALL"

  labels = {
    commit-sha      = "f07324a4d9f6a98b424b653ad2e052f281919410"
    managed-by      = "github-actions"
    managed-by-cnrm = "true"
  }

  launch_stage = "GA"
  location     = "asia-northeast1"
  name         = "dotto-admin-web-dev"
  project      = "swift2023groupc"

  template {
    containers {
      env {
        name  = "NEXT_PUBLIC_FIREBASE_API_KEY"
        value = "REDACTED_FIREBASE_WEB_API_KEY"
      }

      env {
        name  = "NEXT_PUBLIC_FIREBASE_AUTH_DOMAIN"
        value = "swift2023groupc.firebaseapp.com"
      }

      env {
        name  = "NEXT_PUBLIC_FIREBASE_PROJECT_ID"
        value = "swift2023groupc"
      }

      env {
        name  = "NEXT_PUBLIC_FIREBASE_STORAGE_BUCKET"
        value = "swift2023groupc.appspot.com"
      }

      env {
        name  = "NEXT_PUBLIC_FIREBASE_MESSAGING_SENDER_ID"
        value = "107577467292"
      }

      env {
        name  = "NEXT_PUBLIC_FIREBASE_APP_ID"
        value = "1:107577467292:web:ee7a76be001af23106e859"
      }

      env {
        name  = "NEXT_PUBLIC_FIREBASE_MEASUREMENT_ID"
        value = "G-PFZB0H8FLY"
      }

      env {
        name  = "NEXT_PUBLIC_API_BASE_URL"
        value = "https://admin-bff-api-dev-107577467292.asia-northeast1.run.app"
      }

      image = "asia-northeast1-docker.pkg.dev/swift2023groupc/github-actions/dotto-admin-web/dotto-admin-web-dev:f07324a4d9f6a98b424b653ad2e052f281919410"

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
      commit-sha = "f07324a4d9f6a98b424b653ad2e052f281919410"
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
# terraform import google_cloud_run_v2_service.dotto_admin_web_dev projects/swift2023groupc/locations/asia-northeast1/services/dotto-admin-web-dev
