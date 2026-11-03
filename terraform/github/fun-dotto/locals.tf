locals {
  gcp_workload_identity_provider = "projects/107577467292/locations/global/workloadIdentityPools/dotto/providers/github"
  gcp_github_actions_sa          = "github-actions@${var.google_cloud_project_id}.iam.gserviceaccount.com"
  gcp_artifact_registry_hostname = "${var.google_cloud_region}-docker.pkg.dev"

  # Cloud Run へデプロイするリポジトリの共通 Variable
  cloud_run_deploy_variables = {
    PROJECT_ID                 = var.google_cloud_project_id
    SERVICE_ACCOUNT            = local.gcp_github_actions_sa
    WORKLOAD_IDENTITY_PROVIDER = local.gcp_workload_identity_provider
    _AR_HOSTNAME               = local.gcp_artifact_registry_hostname
    _DEPLOY_REGION             = var.google_cloud_region
  }

  # Firebase の Web 設定は公開値のため Secret から Variable へ移行する
  # 値が null のものは Terraform 管理外とする
  web_firebase_variables = {
    NEXT_PUBLIC_FIREBASE_API_KEY             = null
    NEXT_PUBLIC_FIREBASE_AUTH_DOMAIN         = null
    NEXT_PUBLIC_FIREBASE_PROJECT_ID          = null
    NEXT_PUBLIC_FIREBASE_STORAGE_BUCKET      = null
    NEXT_PUBLIC_FIREBASE_MESSAGING_SENDER_ID = null
    NEXT_PUBLIC_FIREBASE_APP_ID              = null
    NEXT_PUBLIC_FIREBASE_MEASUREMENT_ID      = null
    NEXT_PUBLIC_FIREBASE_APPCHECK_SITE_KEY   = null
  }
}
