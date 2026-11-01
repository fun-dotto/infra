module "job" {
  source = "../../../../modules/cloud-run-job"

  project_id = "swift2023groupc"
  location   = "asia-northeast1"

  job_name                     = "dispatch-notifications-job"
  service_account_id           = "noti-user-job"
  service_account_display_name = "Notify User Job"
  project_roles = [
    "roles/cloudsql.client",
    "roles/cloudsql.instanceUser",
    "roles/firebasecloudmessaging.admin",
    "roles/logging.logWriter",
  ]

  command             = ["/bin/dispatch-notifications-job"]
  image               = "asia-northeast1-docker.pkg.dev/swift2023groupc/github-actions/server:latest"
  deletion_protection = true

  cloud_sql = {
    db_name                  = "dotto"
    instance_connection_name = "swift2023groupc:asia-northeast1:dotto"
  }

  schedule = "0 18 * * *"
  timezone = "Asia/Tokyo"
}

moved {
  from = google_service_account.notify_user_job
  to   = module.job.google_service_account.this
}

moved {
  from = google_project_iam_member.notify_user_job
  to   = module.job.google_project_iam_member.this
}

moved {
  from = google_service_account.notify_user_job_scheduler
  to   = module.job.google_service_account.scheduler
}

moved {
  from = google_cloud_run_v2_job_iam_member.notify_user_job_invoker
  to   = module.job.google_cloud_run_v2_job_iam_member.invoker
}

moved {
  from = google_cloud_run_v2_job.notify_user_job
  to   = module.job.google_cloud_run_v2_job.this
}

moved {
  from = google_cloud_scheduler_job.notify_user_job_trigger
  to   = module.job.google_cloud_scheduler_job.trigger
}
