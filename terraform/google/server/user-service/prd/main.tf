module "service" {
  source = "../../../../modules/cloud-run-service"

  project_id = "swift2023groupc"
  location   = "asia-northeast1"

  service_name                 = "user-api"
  service_account_id           = "user-svc"
  service_account_display_name = "User Service"
  project_roles = [
    "roles/cloudsql.client",
    "roles/cloudsql.instanceUser",
    "roles/firebasecloudmessaging.admin",
    "roles/logging.logWriter",
  ]

  command             = ["/bin/user-api"]
  image               = "asia-northeast1-docker.pkg.dev/swift2023groupc/github-actions/server:latest"
  ingress             = "INGRESS_TRAFFIC_ALL"
  deletion_protection = false

  cloud_sql = {
    db_name                  = "dotto"
    instance_connection_name = "swift2023groupc:asia-northeast1:dotto"
  }

  max_instance_count = 10
  min_instance_count = 1
}

moved {
  from = google_service_account.user_service
  to   = module.service.google_service_account.this
}

moved {
  from = google_project_iam_member.user_service
  to   = module.service.google_project_iam_member.this
}

moved {
  from = google_cloud_run_v2_service.user_service
  to   = module.service.google_cloud_run_v2_service.this
}
