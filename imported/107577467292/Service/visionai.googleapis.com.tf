resource "google_project_service" "visionai_googleapis_com" {
  project = "107577467292"
  service = "visionai.googleapis.com"
}
# terraform import google_project_service.visionai_googleapis_com 107577467292/visionai.googleapis.com
