resource "google_project_service" "servicemanagement_googleapis_com" {
  project = "107577467292"
  service = "servicemanagement.googleapis.com"
}
# terraform import google_project_service.servicemanagement_googleapis_com 107577467292/servicemanagement.googleapis.com
