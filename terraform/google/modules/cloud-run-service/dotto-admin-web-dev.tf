resource "google_cloud_run_v2_service" "dotto_admin_web_dev" {
  client               = "gcloud"
  client_version       = "564.0.0"
  ingress              = "INGRESS_TRAFFIC_ALL"
  invoker_iam_disabled = true
  default_uri_disabled = true

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
      dynamic "env" {
        for_each = var.service_envs["dotto_admin_web_dev"]
        content {
          name  = env.key
          value = env.value == "" ? null : env.value
        }
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
# terraform import google_cloud_run_v2_service.dotto_admin_web_dev projects/swift2023groupc/locations/asia-northeast1/services/dotto-admin-web-dev
