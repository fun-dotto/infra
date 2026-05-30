resource "google_project_service" "run_googleapis_com" {
  project = "107577467292"
  service = "run.googleapis.com"
}
# terraform import google_project_service.run_googleapis_com 107577467292/run.googleapis.com
