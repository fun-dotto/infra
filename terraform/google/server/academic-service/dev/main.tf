module "service" {
  source = "../../../../modules/cloud-run-service"

  project_id = "swift2023groupc"
  location   = "asia-northeast1"

  service_name                 = "academic-api-dev"
  service_account_id           = "academic-svc-dev"
  service_account_display_name = "Academic Service (Dev)"
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
    db_name                  = "dotto_dev"
    instance_connection_name = "swift2023groupc:asia-northeast1:dotto"
  }

  max_instance_count = 10
  min_instance_count = 0
}
