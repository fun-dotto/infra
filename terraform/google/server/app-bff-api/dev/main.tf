module "service" {
  source = "../../../../modules/cloud-run-service"

  project_id = "swift2023groupc"
  location   = "asia-northeast1"

  service_name                 = "app-bff-api-dev"
  service_account_id           = "app-bff-api-dev"
  service_account_display_name = "App BFF API (Dev)"
  project_roles = [
    "roles/firebaseappcheck.tokenVerifier",
    "roles/logging.logWriter",
  ]

  command              = ["/bin/app-bff-api"]
  image                = "asia-northeast1-docker.pkg.dev/swift2023groupc/github-actions/server:latest"
  ingress              = "INGRESS_TRAFFIC_ALL"
  invoker_iam_disabled = true
  deletion_protection  = false

  env = [
    {
      name  = "ACADEMIC_API_URL"
      value = data.terraform_remote_state.academic_service.outputs.cloud_run_service_uri
    },
    {
      name  = "ANNOUNCEMENT_API_URL"
      value = data.terraform_remote_state.announcement_service.outputs.cloud_run_service_uri
    },
    {
      name  = "USER_API_URL"
      value = data.terraform_remote_state.user_service.outputs.cloud_run_service_uri
    },
  ]

  max_instance_count = 10
  min_instance_count = 0
}

resource "google_cloud_run_v2_service_iam_member" "academic_service_invoker" {
  name   = data.terraform_remote_state.academic_service.outputs.cloud_run_service_name
  role   = "roles/run.invoker"
  member = "serviceAccount:${module.service.service_account_email}"
}

resource "google_cloud_run_v2_service_iam_member" "announcement_service_invoker" {
  name   = data.terraform_remote_state.announcement_service.outputs.cloud_run_service_name
  role   = "roles/run.invoker"
  member = "serviceAccount:${module.service.service_account_email}"
}

resource "google_cloud_run_v2_service_iam_member" "user_service_invoker" {
  name   = data.terraform_remote_state.user_service.outputs.cloud_run_service_name
  role   = "roles/run.invoker"
  member = "serviceAccount:${module.service.service_account_email}"
}

moved {
  from = google_service_account.app_bff_api
  to   = module.service.google_service_account.this
}

moved {
  from = google_project_iam_member.app_bff_api
  to   = module.service.google_project_iam_member.this
}

moved {
  from = google_cloud_run_v2_service.app_bff_api
  to   = module.service.google_cloud_run_v2_service.this
}
