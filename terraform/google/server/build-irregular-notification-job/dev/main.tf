module "job" {
  source = "../../../../modules/cloud-run-job"

  project_id = "swift2023groupc"
  location   = "asia-northeast1"

  job_name                     = "build-class-change-notifications-job-dev"
  service_account_id           = "bld-irr-noti-job-dev"
  service_account_display_name = "Build Irregular Notification Job (Dev)"
  project_roles = [
    "roles/cloudsql.client",
    "roles/cloudsql.instanceUser",
    "roles/firebasecloudmessaging.admin",
    "roles/logging.logWriter",
  ]

  command             = ["/bin/build-class-change-notifications-job"]
  image               = "asia-northeast1-docker.pkg.dev/swift2023groupc/github-actions/server:latest"
  deletion_protection = false

  cloud_sql = {
    db_name                  = "dotto_dev"
    instance_connection_name = "swift2023groupc:asia-northeast1:dotto"
  }

  schedule = "0 16 * * *"
  timezone = "Asia/Tokyo"
}
