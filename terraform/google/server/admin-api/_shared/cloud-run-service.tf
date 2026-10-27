data "google_project" "default" {}

resource "google_cloud_run_v2_service" "admin_api" {
  # 外部からは cloudflared (Cloudflare Tunnel) 経由でのみ到達させる
  ingress = "INGRESS_TRAFFIC_INTERNAL_ONLY"
  # ID Token を持たない経路 (App Check / Cloudflare Access) からも呼ばれるため IAM 呼び出しチェックは無効化し、アプリ側で認証する
  invoker_iam_disabled = true

  deletion_protection = false

  launch_stage = "GA"
  location     = var.google_cloud_region
  name         = var.service_name

  template {
    execution_environment = null

    containers {
      command = [
        # TODO: admin-api のバイナリが用意できたら "/bin/admin-api" に戻す
        "/bin/admin-bff-api",
      ]

      # TODO: 仮で BFF のバイナリを動かすためだけに必要。統合後の API には不要なので削除する
      env {
        name  = "ACADEMIC_API_URL"
        value = data.terraform_remote_state.academic_service.outputs.cloud_run_service_uri
      }
      # TODO: 仮で BFF のバイナリを動かすためだけに必要。統合後の API には不要なので削除する
      env {
        name  = "ANNOUNCEMENT_API_URL"
        value = data.terraform_remote_state.announcement_service.outputs.cloud_run_service_uri
      }
      # TODO: 仮で BFF のバイナリを動かすためだけに必要。統合後の API には不要なので削除する
      env {
        name  = "USER_API_URL"
        value = data.terraform_remote_state.user_service.outputs.cloud_run_service_uri
      }
      env {
        name  = "CF_ACCESS_ENABLED"
        value = "true"
      }
      env {
        name  = "CF_ACCESS_ISSUER"
        value = data.terraform_remote_state.cloudflare.outputs.access_issuer
      }
      env {
        name  = "CF_ACCESS_AUD"
        value = lookup(lookup(data.terraform_remote_state.cloudflare.outputs.access_auds, local.environment, {}), "admin_api", "")
      }
      env {
        name  = "ID_TOKEN_AUDIENCE"
        value = "https://${var.service_name}-${data.google_project.default.number}.${var.google_cloud_region}.run.app"
      }
      env {
        name  = "ID_TOKEN_ALLOWED_SERVICE_ACCOUNTS"
        value = "${var.id_token_allowed_service_account_id}@${var.google_cloud_project_id}.iam.gserviceaccount.com"
      }
      env {
        name  = "DB_IAM_USER"
        value = trimsuffix(google_service_account.admin_api.email, ".gserviceaccount.com")
      }
      env {
        name  = "DB_NAME"
        value = var.db_name
      }
      env {
        name  = "INSTANCE_CONNECTION_NAME"
        value = var.instance_connection_name
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

    service_account = google_service_account.admin_api.email
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
