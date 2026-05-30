resource "google_project_service" "secretmanager_googleapis_com" {
  project = "107577467292"
  service = "secretmanager.googleapis.com"
}
# terraform import google_project_service.secretmanager_googleapis_com 107577467292/secretmanager.googleapis.com
