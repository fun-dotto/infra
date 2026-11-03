data "google_project" "default" {}

module "service" {
  source = "../../../../modules/cloud-run-service"

  project_id = "swift2023groupc"
  location   = "asia-northeast1"

  service_name                 = "app-api"
  service_account_id           = "app-api"
  service_account_display_name = "App API"
  project_roles = [
    "roles/cloudsql.client",
    "roles/cloudsql.instanceUser",
    "roles/firebaseappcheck.tokenVerifier",
    "roles/logging.logWriter",
  ]

  command = ["/bin/app-api"]
  image   = "asia-northeast1-docker.pkg.dev/swift2023groupc/github-actions/server:latest"
  # Access をかけず Tunnel も通さないため、Cloudflare プロキシから直接受ける（App Check / ID Token で認証する）
  ingress = "INGRESS_TRAFFIC_ALL"
  # ID Token を持たない経路 (App Check / Cloudflare Access) からも呼ばれるため IAM 呼び出しチェックは無効化し、アプリ側で認証する
  invoker_iam_disabled = true
  deletion_protection  = false

  env = [
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
      value = lookup(lookup(data.terraform_remote_state.cloudflare.outputs.access_auds, "prd", {}), "app_api", "")
    },
    {
      name  = "ID_TOKEN_AUDIENCE"
      value = "https://app-api-${data.google_project.default.number}.asia-northeast1.run.app"
    },
    {
      name  = "ID_TOKEN_ALLOWED_SERVICE_ACCOUNTS"
      value = "web-prd@swift2023groupc.iam.gserviceaccount.com"
    },
  ]

  cloud_sql = {
    db_name                  = "dotto"
    instance_connection_name = "swift2023groupc:asia-northeast1:dotto"
  }

  max_instance_count = 10
  min_instance_count = 0 # TODO: 本番運用開始時に 1 に戻す
}
