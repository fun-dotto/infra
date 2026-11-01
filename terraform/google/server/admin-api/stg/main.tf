data "google_project" "default" {}

module "service" {
  source = "../../../../modules/cloud-run-service"

  project_id = "swift2023groupc"
  location   = "asia-northeast1"

  service_name                 = "admin-api-stg"
  service_account_id           = "admin-api-stg"
  service_account_display_name = "Admin API (Stg)"
  project_roles = [
    "roles/cloudsql.client",
    "roles/cloudsql.instanceUser",
    "roles/logging.logWriter",
  ]

  # TODO: admin-api のバイナリが用意できたら "/bin/admin-api" に戻す
  command = ["/bin/admin-bff-api"]
  image   = "asia-northeast1-docker.pkg.dev/swift2023groupc/github-actions/server:latest"
  # 外部からは cloudflared (Cloudflare Tunnel) 経由でのみ到達させる
  ingress = "INGRESS_TRAFFIC_INTERNAL_ONLY"
  # ID Token を持たない経路 (App Check / Cloudflare Access) からも呼ばれるため IAM 呼び出しチェックは無効化し、アプリ側で認証する
  invoker_iam_disabled = true
  deletion_protection  = false

  env = [
    # TODO: 仮で BFF のバイナリを動かすためだけに必要。統合後の API には不要なので削除する
    {
      name  = "ACADEMIC_API_URL"
      value = data.terraform_remote_state.academic_service.outputs.cloud_run_service_uri
    },
    # TODO: 仮で BFF のバイナリを動かすためだけに必要。統合後の API には不要なので削除する
    {
      name  = "ANNOUNCEMENT_API_URL"
      value = data.terraform_remote_state.announcement_service.outputs.cloud_run_service_uri
    },
    # TODO: 仮で BFF のバイナリを動かすためだけに必要。統合後の API には不要なので削除する
    {
      name  = "USER_API_URL"
      value = data.terraform_remote_state.user_service.outputs.cloud_run_service_uri
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
      value = lookup(lookup(data.terraform_remote_state.cloudflare.outputs.access_auds, "stg", {}), "admin_api", "")
    },
    {
      name  = "ID_TOKEN_AUDIENCE"
      value = "https://admin-api-stg-${data.google_project.default.number}.asia-northeast1.run.app"
    },
    {
      name  = "ID_TOKEN_ALLOWED_SERVICE_ACCOUNTS"
      value = "admin-web-stg@swift2023groupc.iam.gserviceaccount.com"
    },
  ]

  cloud_sql = {
    db_name                  = "dotto_stg"
    instance_connection_name = "swift2023groupc:asia-northeast1:dotto"
  }

  max_instance_count = 10
  min_instance_count = 0
}
