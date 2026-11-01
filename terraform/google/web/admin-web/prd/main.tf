module "service" {
  source = "../../../../modules/cloud-run-service"

  project_id = "swift2023groupc"
  location   = "asia-northeast1"

  service_name                 = "admin-web"
  service_account_id           = "admin-web"
  service_account_display_name = "Admin Web"
  project_roles = [
    "roles/logging.logWriter",
  ]

  image = "asia-northeast1-docker.pkg.dev/swift2023groupc/github-actions/admin-web:latest"
  # Cloudflare Tunnel (cloudflared) 経由でのみ受け付け、Access の認証を必ず通す
  ingress              = "INGRESS_TRAFFIC_INTERNAL_ONLY"
  invoker_iam_disabled = true
  default_uri_disabled = false
  deletion_protection  = true

  env = [
    {
      # Access の Service Token で認証するため、Cloudflare 経由の公開ホスト名で呼ぶ
      name  = "ADMIN_API_URL"
      value = "https://${data.terraform_remote_state.cloudflare.outputs.hostnames["prd/admin_api"]}"
    },
    {
      name  = "CF_ACCESS_CLIENT_ID"
      value = data.terraform_remote_state.cloudflare.outputs.admin_web_service_token_client_ids["prd"]
    },
    {
      name      = "CF_ACCESS_CLIENT_SECRET"
      secret_id = google_secret_manager_secret.cf_access_client_secret.secret_id
    },
    {
      name  = "CF_ACCESS_ENABLED"
      value = "true"
    },
    {
      name  = "CF_ACCESS_ISSUER"
      value = data.terraform_remote_state.cloudflare.outputs.access_issuer
    },
    {
      name  = "CF_ACCESS_AUD"
      value = lookup(lookup(data.terraform_remote_state.cloudflare.outputs.access_auds, "prd", {}), "admin_web", "")
    },
  ]

  # internal ingress の API を VPC 経由で呼ぶ
  vpc_access = {
    egress     = "PRIVATE_RANGES_ONLY"
    network    = data.terraform_remote_state.network.outputs.network_name
    subnetwork = data.terraform_remote_state.network.outputs.cloud_run_subnetwork_name
  }

  max_instance_count = 10
  min_instance_count = 0

  # Secret のバージョンがないとリビジョンを起動できない
  depends_on = [google_secret_manager_secret_version.cf_access_client_secret]
}
