resource "google_service_account" "class_change_batch_job" {
  account_id   = "class-change-batch-job"
  display_name = "Class Change Batch Cloud Run Job"
}

resource "google_project_iam_member" "class_change_batch_job" {
  for_each = toset([
    "roles/cloudsql.client",
    "roles/cloudsql.instanceUser",
  ])

  project = var.google_cloud_project_id
  role    = each.value
  member  = "serviceAccount:${google_service_account.class_change_batch_job.email}"
}
