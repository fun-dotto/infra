module "service" {
  source = "../../../../modules/cloud-run-service"

  project_id = "swift2023groupc"
  location   = "asia-northeast1"

  service_name                 = "academic-api-stg"
  service_account_id           = "academic-svc-stg"
  service_account_display_name = "Academic Service (Stg)"
  project_roles = [
    "roles/cloudsql.client",
    "roles/cloudsql.instanceUser",
    "roles/logging.logWriter",
  ]

  command             = ["/bin/academic-api"]
  image               = "asia-northeast1-docker.pkg.dev/swift2023groupc/github-actions/server:latest"
  ingress             = "INGRESS_TRAFFIC_ALL"
  deletion_protection = false

  cloud_sql = {
    db_name                  = "dotto_stg"
    instance_connection_name = "swift2023groupc:asia-northeast1:dotto"
  }

  max_instance_count = 10
  min_instance_count = 0
}

moved {
  from = google_service_account.academic_service
  to   = module.service.google_service_account.this
}

moved {
  from = google_project_iam_member.academic_service
  to   = module.service.google_project_iam_member.this
}

moved {
  from = google_cloud_run_v2_service.academic_service
  to   = module.service.google_cloud_run_v2_service.this
}
