module "service" {
  source = "../../../../modules/cloud-run-service"

  project_id = "swift2023groupc"
  location   = "asia-northeast1"

  service_name                 = "web-dev"
  service_account_id           = "web-dev"
  service_account_display_name = "Web (Dev)"
  project_roles = [
    "roles/firebaseappcheck.tokenVerifier",
    "roles/logging.logWriter",
  ]

  image = "asia-northeast1-docker.pkg.dev/swift2023groupc/github-actions/web:latest"
  # Cloudflare Tunnel (cloudflared) 経由でのみ受け付け、Access の認証を必ず通す
  ingress              = "INGRESS_TRAFFIC_INTERNAL_ONLY"
  invoker_iam_disabled = true
  default_uri_disabled = false
  deletion_protection  = true

  env = [
    {
      name  = "DOTTO_ENV"
      value = "dev"
    },
    {
      name  = "FIREBASE_API_KEY"
      value = data.google_firebase_web_app_config.default.api_key
    },
    {
      name  = "FIREBASE_AUTH_DOMAIN"
      value = data.google_firebase_web_app_config.default.auth_domain
    },
    {
      name  = "FIREBASE_PROJECT_ID"
      value = data.google_project.default.project_id
    },
    {
      name  = "FIREBASE_STORAGE_BUCKET"
      value = data.google_firebase_web_app_config.default.storage_bucket
    },
    {
      name  = "FIREBASE_MESSAGING_SENDER_ID"
      value = data.google_firebase_web_app_config.default.messaging_sender_id
    },
    {
      name  = "FIREBASE_APP_ID"
      value = data.google_firebase_web_app_config.default.web_app_id
    },
    {
      name  = "FIREBASE_MEASUREMENT_ID"
      value = data.google_firebase_web_app_config.default.measurement_id
    },
    {
      name  = "API_BASE_URL"
      value = data.terraform_remote_state.app_bff_api.outputs.cloud_run_service_uri
    },
    {
      # app-api は本サービスのサービスアカウントを参照するため、remote state ではなく URI を組み立てて循環を避ける
      name  = "APP_API_URL"
      value = "https://app-api-dev-${data.google_project.default.number}.asia-northeast1.run.app"
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
      value = lookup(lookup(data.terraform_remote_state.cloudflare.outputs.access_auds, "dev", {}), "web", "")
    },
    {
      name      = "NOTION_TOKEN"
      secret_id = google_secret_manager_secret.notion_token.secret_id
    },
    {
      name  = "NOTION_MAC_DATABASE_ID"
      value = "33528560ac7980698b3bcc050130d91a"
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
