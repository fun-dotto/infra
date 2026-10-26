data "google_project" "default" {}

resource "google_cloud_run_v2_service" "app_api" {
  # 外部からは cloudflared (Cloudflare Tunnel) 経由でのみ到達させる
  # prd は Access をかけず Tunnel も通さないため、Cloudflare プロキシから直接受ける（App Check / ID Token で認証する）
  ingress = local.environment == "prd" ? "INGRESS_TRAFFIC_ALL" : "INGRESS_TRAFFIC_INTERNAL_ONLY"
  # ID Token を持たない経路 (App Check / Cloudflare Access) からも呼ばれるため IAM 呼び出しチェックは無効化し、アプリ側で認証する
  invoker_iam_disabled = true

  launch_stage = "GA"
  location     = var.google_cloud_region
  name         = var.service_name

  template {
    execution_environment = null

    containers {
      command = [
        "/bin/app-api",
      ]

      env {
        name  = "CF_ACCESS_ENABLED"
        value = local.environment == "prd" ? "false" : "true"
      }
      env {
        name  = "CF_ACCESS_ISSUER"
        value = data.terraform_remote_state.cloudflare.outputs.access_issuer
      }
      env {
        name  = "CF_ACCESS_AUD"
        value = lookup(lookup(data.terraform_remote_state.cloudflare.outputs.access_auds, local.environment, {}), "app_api", "")
      }
      env {
        name  = "ID_TOKEN_AUDIENCE"
        value = "https://${var.service_name}-${data.google_project.default.number}.${var.google_cloud_region}.run.app"
      }
      env {
        name  = "ID_TOKEN_ALLOWED_SERVICE_ACCOUNTS"
        value = data.terraform_remote_state.web.outputs.service_account_email
      }

      image = var.image

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

    service_account = google_service_account.app_api.email
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
