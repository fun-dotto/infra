module "job" {
  source = "../../../../modules/cloud-run-job"

  project_id = "swift2023groupc"
  location   = "asia-northeast1"

  job_name                     = "import-gtfs-job"
  service_account_id           = "import-gtfs-job"
  service_account_display_name = "Import GTFS Job"
  project_roles = [
    "roles/cloudsql.client",
    "roles/cloudsql.instanceUser",
    "roles/logging.logWriter",
  ]

  command             = ["/bin/import-gtfs-job"]
  image               = "asia-northeast1-docker.pkg.dev/swift2023groupc/github-actions/server:latest"
  deletion_protection = false

  cloud_sql = {
    db_name                  = "dotto"
    instance_connection_name = "swift2023groupc:asia-northeast1:dotto"
  }

  secret_env = [
    {
      name      = "GTFS_SCHEDULE_URL"
      secret_id = "gtfs_schedule_url_hakodate_bus"
    },
  ]

  schedule = "0 21 * * *"
  timezone = "Asia/Tokyo"
}
