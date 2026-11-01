module "job" {
  source = "../../../../modules/cloud-run-job"

  project_id = "swift2023groupc"
  location   = "asia-northeast1"

  job_name                     = "build-class-change-notifications-job"
  service_account_id           = "bld-irr-noti-job"
  service_account_display_name = "Build Irregular Notification Job"
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
    db_name                  = "dotto"
    instance_connection_name = "swift2023groupc:asia-northeast1:dotto"
  }

  schedule = "30 17 * * *"
  timezone = "Asia/Tokyo"
}

moved {
  from = google_service_account.build_irregular_notification_job
  to   = module.job.google_service_account.this
}

moved {
  from = google_project_iam_member.build_irregular_notification_job
  to   = module.job.google_project_iam_member.this
}

moved {
  from = google_service_account.build_irregular_notification_job_scheduler
  to   = module.job.google_service_account.scheduler
}

moved {
  from = google_cloud_run_v2_job_iam_member.build_irregular_notification_job_invoker
  to   = module.job.google_cloud_run_v2_job_iam_member.invoker
}

moved {
  from = google_cloud_run_v2_job.build_irregular_notification_job
  to   = module.job.google_cloud_run_v2_job.this
}

moved {
  from = google_cloud_scheduler_job.build_irregular_notification_job_trigger
  to   = module.job.google_cloud_scheduler_job.trigger
}
