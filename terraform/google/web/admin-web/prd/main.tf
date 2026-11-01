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
      # admin-api は本サービスのサービスアカウントを参照するため、remote state ではなく URI を組み立てて循環を避ける
      name  = "ADMIN_API_URL"
      value = "https://admin-api-${data.google_project.default.number}.asia-northeast1.run.app"
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
}
