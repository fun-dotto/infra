resource "google_cloud_run_v2_worker_pool" "cloudflared" {
  deletion_protection = false
  launch_stage        = "GA"
  location            = var.google_cloud_region
  name                = "cloudflared"

  scaling {
    scaling_mode          = "MANUAL"
    manual_instance_count = var.instance_count
  }

  template {
    containers {
      image = var.image
      args = [
        "tunnel",
        "--no-autoupdate",
        "--metrics",
        "0.0.0.0:2000",
        # Cloud Run では UDP の受信バッファが足りず QUIC の接続に失敗するため HTTP/2 を使う
        "--protocol",
        "http2",
        "run",
      ]

      env {
        name = "TUNNEL_TOKEN"

        value_source {
          secret_key_ref {
            secret  = google_secret_manager_secret.tunnel_token.secret_id
            version = google_secret_manager_secret_version.tunnel_token.version
          }
        }
      }

      resources {
        limits = {
          cpu    = "1"
          memory = "512Mi"
        }
      }
    }

    # *.run.app 宛てを VPC (Private Google Access) 経由にして internal ingress の Cloud Run に届かせる
    vpc_access {
      egress = "PRIVATE_RANGES_ONLY"

      network_interfaces {
        network    = data.terraform_remote_state.network.outputs.network_name
        subnetwork = data.terraform_remote_state.network.outputs.cloud_run_subnetwork_name
      }
    }

    service_account = google_service_account.cloudflared.email
  }

  depends_on = [
    google_secret_manager_secret_iam_member.tunnel_token,
  ]
}
