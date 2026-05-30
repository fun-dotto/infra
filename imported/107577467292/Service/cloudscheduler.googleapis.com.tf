resource "google_project_service" "cloudscheduler_googleapis_com" {
  project = "107577467292"
  service = "cloudscheduler.googleapis.com"
}
# terraform import google_project_service.cloudscheduler_googleapis_com 107577467292/cloudscheduler.googleapis.com
