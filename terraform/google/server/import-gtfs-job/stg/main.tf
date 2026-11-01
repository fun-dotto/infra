module "job" {
  source = "../../../../modules/cloud-run-job"

  project_id = "swift2023groupc"
  location   = "asia-northeast1"

  job_name                     = "import-gtfs-job-stg"
  service_account_id           = "import-gtfs-job-stg"
  service_account_display_name = "Import GTFS Job (Stg)"
  project_roles = [
    "roles/cloudsql.client",
    "roles/cloudsql.instanceUser",
    "roles/logging.logWriter",
  ]

  command             = ["/bin/import-gtfs-job"]
  image               = "asia-northeast1-docker.pkg.dev/swift2023groupc/github-actions/server:latest"
  deletion_protection = false

  cloud_sql = {
    db_name                  = "dotto_stg"
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

moved {
  from = google_service_account.import_gtfs_job
  to   = module.job.google_service_account.this
}

moved {
  from = google_project_iam_member.import_gtfs_job
  to   = module.job.google_project_iam_member.this
}

moved {
  from = google_service_account.import_gtfs_job_scheduler
  to   = module.job.google_service_account.scheduler
}

moved {
  from = google_cloud_run_v2_job_iam_member.import_gtfs_job_invoker
  to   = module.job.google_cloud_run_v2_job_iam_member.invoker
}

moved {
  from = google_cloud_run_v2_job.import_gtfs_job
  to   = module.job.google_cloud_run_v2_job.this
}

moved {
  from = google_cloud_scheduler_job.import_gtfs_job_trigger
  to   = module.job.google_cloud_scheduler_job.trigger
}

moved {
  from = google_secret_manager_secret_iam_member.import_gtfs_job_gtfs_schedule_url
  to   = module.job.google_secret_manager_secret_iam_member.secret_env["GTFS_SCHEDULE_URL"]
}
