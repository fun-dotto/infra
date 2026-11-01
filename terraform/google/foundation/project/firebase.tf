resource "google_firebase_project" "default" {
  provider = google-beta.firebase
  project  = google_project.default.project_id

  lifecycle {
    prevent_destroy = true
  }
}
