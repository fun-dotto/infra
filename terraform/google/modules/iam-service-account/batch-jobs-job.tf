resource "google_service_account" "batch_jobs_job" {
  account_id   = "batch-jobs-job"
  display_name = "Batch Jobs (Go) Cloud Run Job"
}

resource "google_project_iam_member" "batch_jobs_job" {
  for_each = toset([
    "projects/${var.google_cloud_project_id}/roles/fcmSender",
    "roles/cloudsql.client",
    "roles/cloudsql.instanceUser",
  ])

  project = var.google_cloud_project_id
  role    = each.value
  member  = "serviceAccount:${google_service_account.batch_jobs_job.email}"
}
