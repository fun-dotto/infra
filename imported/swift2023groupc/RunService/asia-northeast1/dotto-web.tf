resource "google_cloud_run_v2_service" "dotto_web" {
  client         = "gcloud"
  client_version = "564.0.0"
  ingress        = "INGRESS_TRAFFIC_ALL"

  labels = {
    commit-sha      = "230609cd346f7e06598ff37ca1578088d4ea4ab7"
    managed-by      = "github-actions"
    managed-by-cnrm = "true"
  }

  launch_stage = "GA"
  location     = "asia-northeast1"
  name         = "dotto-web"
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
        value = "1:107577467292:web:5dc6af0a958bb41d06e859"
      }

      env {
        name = "NEXT_PUBLIC_FIREBASE_MEASUREMENT_ID"
      }

      env {
        name  = "NEXT_PUBLIC_GA_MEASUREMENT_ID"
        value = "G-HPH8E163RP"
      }

      env {
        name  = "NOTION_TOKEN"
        value = "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"
      }

      env {
        name  = "NOTION_MAC_DATABASE_ID"
        value = "33528560ac7980698b3bcc050130d91a"
      }

      env {
        name  = "NEXT_PUBLIC_API_BASE_URL"
        value = "https://app-bff-api-107577467292.asia-northeast1.run.app"
      }

      image = "asia-northeast1-docker.pkg.dev/swift2023groupc/github-actions/dotto-web/dotto-web:230609cd346f7e06598ff37ca1578088d4ea4ab7"

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
      commit-sha = "230609cd346f7e06598ff37ca1578088d4ea4ab7"
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
# terraform import google_cloud_run_v2_service.dotto_web projects/swift2023groupc/locations/asia-northeast1/services/dotto-web
