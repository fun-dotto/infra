resource "google_project_service" "notebooks_googleapis_com" {
  project = "107577467292"
  service = "notebooks.googleapis.com"
}
# terraform import google_project_service.notebooks_googleapis_com 107577467292/notebooks.googleapis.com
