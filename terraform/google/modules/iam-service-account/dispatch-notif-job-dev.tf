resource "google_service_account" "dispatch_notif_job_dev" {
  account_id   = "dispatch-notif-job-dev"
  display_name = "dispatch-notifications-job-dev"
}

resource "google_project_iam_member" "dispatch_notif_job_dev" {
  for_each = toset([
    "projects/${var.google_cloud_project_id}/roles/fcmSender",
    "roles/cloudsql.client",
    "roles/cloudsql.instanceUser",
  ])

  project = var.google_cloud_project_id
  role    = each.value
  member  = "serviceAccount:${google_service_account.dispatch_notif_job_dev.email}"
}
