module "job" {
  source = "../../../../modules/cloud-run-job"

  project_id = "swift2023groupc"
  location   = "asia-northeast1"

  job_name                     = "dispatch-notifications-job-stg"
  service_account_id           = "noti-user-job-stg"
  service_account_display_name = "Notify User Job (Stg)"
  project_roles = [
    "roles/cloudsql.client",
    "roles/cloudsql.instanceUser",
    "roles/firebasecloudmessaging.admin",
    "roles/logging.logWriter",
  ]

  command             = ["/bin/dispatch-notifications-job"]
  image               = "asia-northeast1-docker.pkg.dev/swift2023groupc/github-actions/server:latest"
  deletion_protection = false

  cloud_sql = {
    db_name                  = "dotto_stg"
    instance_connection_name = "swift2023groupc:asia-northeast1:dotto"
  }

  schedule = "0 18 * * *"
  timezone = "Asia/Tokyo"
}
