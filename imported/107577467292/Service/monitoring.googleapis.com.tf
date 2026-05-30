resource "google_project_service" "monitoring_googleapis_com" {
  project = "107577467292"
  service = "monitoring.googleapis.com"
}
# terraform import google_project_service.monitoring_googleapis_com 107577467292/monitoring.googleapis.com
