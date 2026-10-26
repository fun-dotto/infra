resource "google_cloud_run_v2_service" "web" {
  # dev / stg は Cloudflare Tunnel (cloudflared) 経由でのみ受け付け、Access の認証を必ず通す
  # prd は Access をかけず Tunnel も通さないため、ドメインマッピングで直接受ける
  ingress              = endswith(var.service_name, "-dev") || endswith(var.service_name, "-stg") ? "INGRESS_TRAFFIC_INTERNAL_ONLY" : "INGRESS_TRAFFIC_ALL"
  invoker_iam_disabled = true
  default_uri_disabled = false

  launch_stage = "GA"
  location     = var.google_cloud_region
  name         = var.service_name

  template {
    containers {
      env {
        name  = "APP_API_URL"
        value = local.app_api_url
      }
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
        value = lookup(lookup(data.terraform_remote_state.cloudflare.outputs.access_auds, local.environment, {}), "web", "")
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

    # internal ingress の API を VPC 経由で呼ぶ
    vpc_access {
      egress = "PRIVATE_RANGES_ONLY"

      network_interfaces {
        network    = data.terraform_remote_state.network.outputs.network_name
        subnetwork = data.terraform_remote_state.network.outputs.cloud_run_subnetwork_name
      }
    }

    service_account = google_service_account.web.email
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
