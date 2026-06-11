resource "google_service_account" "migrate_job_dev" {
  account_id   = "migrate-job-dev"
  display_name = "migrate-job-dev"
}

resource "google_project_iam_member" "migrate_job_dev" {
  for_each = toset([
    "roles/cloudsql.client",
    "roles/cloudsql.instanceUser",
  ])

  project = var.google_cloud_project_id
  role    = each.value
  member  = "serviceAccount:${google_service_account.migrate_job_dev.email}"
}
