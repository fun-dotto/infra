resource "google_cloud_run_v2_worker_pool" "cloudflared" {
  name     = var.worker_pool_name
  location = var.google_cloud_region

  deletion_protection = false

  template {
    service_account = google_service_account.cloudflared.email

    containers {
      name  = "cloudflared"
      image = var.cloudflared_image

      command = ["cloudflared"]
      args = [
        "tunnel",
        "--no-autoupdate",
        "--loglevel",
        "info",
        "--metrics",
        "0.0.0.0:2000",
        "--protocol",
        "http2",
        "run",
      ]

      env {
        name = "TUNNEL_TOKEN"
        value_source {
          secret_key_ref {
            secret  = google_secret_manager_secret.tunnel_token.secret_id
            version = var.tunnel_token_secret_version
          }
        }
      }

      resources {
        limits = {
          cpu    = "1"
          memory = "512Mi"
        }
      }

      liveness_probe {
        initial_delay_seconds = 180
        timeout_seconds       = 1
        period_seconds        = 10
        failure_threshold     = 1

        http_get {
          path = "/ready"
          port = 2000
        }
      }
    }

    vpc_access {
      egress = "PRIVATE_RANGES_ONLY"

      network_interfaces {
        network    = google_compute_network.cloudflared.name
        subnetwork = google_compute_subnetwork.cloudflared.name
      }
    }
  }

  scaling {
    manual_instance_count = 1
  }

  lifecycle {
    ignore_changes = [
      client,
      client_version,
    ]
  }

  depends_on = [
    google_project_service.required,
    google_secret_manager_secret_iam_member.cloudflared,
  ]
}
