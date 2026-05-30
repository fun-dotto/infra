resource "google_project_service" "testing_googleapis_com" {
  project = "107577467292"
  service = "testing.googleapis.com"
}
# terraform import google_project_service.testing_googleapis_com 107577467292/testing.googleapis.com
