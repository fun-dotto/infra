resource "google_project" "default" {
  provider        = google-beta
  project_id      = var.google_cloud_project_id
  name            = var.google_cloud_project_name
  billing_account = var.google_cloud_billing_account

  lifecycle {
    prevent_destroy = true
  }
}
