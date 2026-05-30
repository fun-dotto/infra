resource "google_project_service" "servicecontrol_googleapis_com" {
  project = "107577467292"
  service = "servicecontrol.googleapis.com"
}
# terraform import google_project_service.servicecontrol_googleapis_com 107577467292/servicecontrol.googleapis.com
