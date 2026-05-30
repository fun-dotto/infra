resource "google_project_service" "cloudfunctions_googleapis_com" {
  project = "107577467292"
  service = "cloudfunctions.googleapis.com"
}
# terraform import google_project_service.cloudfunctions_googleapis_com 107577467292/cloudfunctions.googleapis.com
