resource "google_cloud_scheduler_job" "import_gtfs_job_trigger" {
  name      = "${var.service_name}-trigger"
  schedule  = var.schedule
  time_zone = var.timezone

  http_target {
    http_method = "POST"
    uri         = "https://run.googleapis.com/v2/projects/${google_cloud_run_v2_job.import_gtfs_job.project}/locations/${google_cloud_run_v2_job.import_gtfs_job.location}/jobs/${google_cloud_run_v2_job.import_gtfs_job.name}:run"
    headers = {
      "Content-Type" = "application/json"
    }
    body = base64encode("{}")

    oauth_token {
      service_account_email = google_service_account.import_gtfs_job_scheduler.email
    }
  }
}
