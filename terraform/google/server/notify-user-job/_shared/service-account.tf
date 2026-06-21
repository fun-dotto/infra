resource "google_service_account" "notify_user_job" {
  account_id   = var.service_account_id
  display_name = var.service_account_display_name
}

resource "google_project_iam_member" "notify_user_job" {
  for_each = toset([
    "roles/cloudsql.client",
    "roles/cloudsql.instanceUser",
    "roles/firebasecloudmessaging.admin",
    "roles/logging.logWriter",
  ])

  project = var.google_cloud_project_id
  role    = each.value
  member  = "serviceAccount:${google_service_account.notify_user_job.email}"
}

resource "google_service_account" "notify_user_job_scheduler" {
  account_id   = "${var.service_account_id}-scheduler"
  display_name = "${var.service_account_display_name} Scheduler"
}

resource "google_cloud_run_v2_job_iam_member" "notify_user_job_invoker" {
  name   = google_cloud_run_v2_job.notify_user_job.name
  role   = "roles/run.invoker"
  member = "serviceAccount:${google_service_account.notify_user_job_scheduler.email}"
}
