resource "google_service_account" "admin_api" {
  account_id   = var.service_account_id
  display_name = var.service_account_display_name
}

resource "google_project_iam_member" "admin_api" {
  for_each = toset([
    "roles/logging.logWriter",
  ])

  project = var.google_cloud_project_id
  role    = each.value
  member  = "serviceAccount:${google_service_account.admin_api.email}"
}

resource "google_cloud_run_v2_service_iam_member" "academic_service_invoker" {
  name   = data.terraform_remote_state.academic_service.outputs.cloud_run_service_name
  role   = "roles/run.invoker"
  member = "serviceAccount:${google_service_account.admin_api.email}"
}

resource "google_cloud_run_v2_service_iam_member" "announcement_service_invoker" {
  name   = data.terraform_remote_state.announcement_service.outputs.cloud_run_service_name
  role   = "roles/run.invoker"
  member = "serviceAccount:${google_service_account.admin_api.email}"
}

resource "google_cloud_run_v2_service_iam_member" "funch_service_invoker" {
  name   = data.terraform_remote_state.funch_service.outputs.cloud_run_service_name
  role   = "roles/run.invoker"
  member = "serviceAccount:${google_service_account.admin_api.email}"
}

resource "google_cloud_run_v2_service_iam_member" "user_service_invoker" {
  name   = data.terraform_remote_state.user_service.outputs.cloud_run_service_name
  role   = "roles/run.invoker"
  member = "serviceAccount:${google_service_account.admin_api.email}"
}
