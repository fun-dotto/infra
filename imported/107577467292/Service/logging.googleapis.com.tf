resource "google_project_service" "logging_googleapis_com" {
  project = "107577467292"
  service = "logging.googleapis.com"
}
# terraform import google_project_service.logging_googleapis_com 107577467292/logging.googleapis.com
