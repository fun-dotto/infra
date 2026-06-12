resource "google_service_account" "class_change_notif_job_dev" {
  account_id   = "class-change-notif-job-dev"
  display_name = "build-class-change-notifications-job-dev"
}

resource "google_project_iam_member" "class_change_notif_job_dev" {
  for_each = toset([
    "roles/cloudsql.client",
    "roles/cloudsql.instanceUser",
  ])

  project = var.google_cloud_project_id
  role    = each.value
  member  = "serviceAccount:${google_service_account.class_change_notif_job_dev.email}"
}
