resource "google_project_service" "serviceusage_googleapis_com" {
  project = "107577467292"
  service = "serviceusage.googleapis.com"
}
# terraform import google_project_service.serviceusage_googleapis_com 107577467292/serviceusage.googleapis.com
