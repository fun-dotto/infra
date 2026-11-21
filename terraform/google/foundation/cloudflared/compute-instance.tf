locals {
  cloudflared_command = [
    "tunnel",
    "--no-autoupdate",
    "--metrics",
    "localhost:2000",
    "--protocol",
    "http2",
    "run",
  ]
}

# Cloud Run Worker Pool より安価な e2-micro 上で cloudflared を動かす。
# VM に外部 IP を持たせることで、インターネットへ出るための Cloud NAT (約 $32/月の固定費) を不要にする。
resource "google_compute_instance" "cloudflared" {
  name         = "cloudflared"
  machine_type = "e2-micro"
  zone         = "${var.google_cloud_region}-a"

  boot_disk {
    initialize_params {
      image = "cos-cloud/cos-stable"
      size  = 10
      type  = "pd-standard"
    }
  }

  network_interface {
    network    = data.terraform_remote_state.network.outputs.network_name
    subnetwork = data.terraform_remote_state.network.outputs.cloud_run_subnetwork_name

    # 外部からのアクセスはファイアウォールで許可しない。アウトバウンド専用。
    access_config {}
  }

  service_account {
    email  = google_service_account.cloudflared.email
    scopes = ["cloud-platform"]
  }

  scheduling {
    automatic_restart = true
  }

  metadata_startup_script = <<-EOT
    #!/bin/bash
    set -euo pipefail

    ACCESS_TOKEN=$(curl -sS -H 'Metadata-Flavor: Google' \
      'http://metadata.google.internal/computeMetadata/v1/instance/service-accounts/default/token' \
      | sed -n 's/.*"access_token":"\([^"]*\)".*/\1/p')
    TUNNEL_TOKEN=$(curl -sS -H "Authorization: Bearer $ACCESS_TOKEN" \
      'https://secretmanager.googleapis.com/v1/projects/${var.google_cloud_project_id}/secrets/${google_secret_manager_secret.tunnel_token.secret_id}/versions/latest:access' \
      | sed -n 's/.*"data":"\([^"]*\)".*/\1/p' | base64 -d)

    docker run -d --name cloudflared --restart=always \
      -e TUNNEL_TOKEN \
      '${var.image}' ${join(" ", local.cloudflared_command)}
  EOT

  depends_on = [
    google_secret_manager_secret_iam_member.tunnel_token,
  ]
}
