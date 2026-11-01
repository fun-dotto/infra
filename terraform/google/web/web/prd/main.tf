module "service" {
  source = "../../../../modules/cloud-run-service"

  project_id = "swift2023groupc"
  location   = "asia-northeast1"

  service_name                 = "web"
  service_account_id           = "web-prd"
  service_account_display_name = "Web"
  project_roles = [
    "roles/firebaseappcheck.tokenVerifier",
    "roles/logging.logWriter",
  ]

  image = "asia-northeast1-docker.pkg.dev/swift2023groupc/github-actions/web:latest"
  # Access をかけず Tunnel も通さないため、ドメインマッピングで直接受ける
  ingress              = "INGRESS_TRAFFIC_ALL"
  invoker_iam_disabled = true
  default_uri_disabled = false
  deletion_protection  = true

  env = [
    {
      name  = "API_BASE_URL"
      value = data.terraform_remote_state.app_bff_api.outputs.cloud_run_service_uri
    },
    {
      # app-api は本サービスのサービスアカウントを参照するため、remote state ではなく URI を組み立てて循環を避ける
      name  = "APP_API_URL"
      value = "https://app-api-${data.google_project.default.number}.asia-northeast1.run.app"
    },
    {
      name  = "CF_ACCESS_ENABLED"
      value = "false"
    },
    {
      name  = "CF_ACCESS_ISSUER"
      value = data.terraform_remote_state.cloudflare.outputs.access_issuer
    },
    {
      name  = "CF_ACCESS_AUD"
      value = lookup(lookup(data.terraform_remote_state.cloudflare.outputs.access_auds, "prd", {}), "web", "")
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

  max_instance_count = 10
  min_instance_count = 0
}
