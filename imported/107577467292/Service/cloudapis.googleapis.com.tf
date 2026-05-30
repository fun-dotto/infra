resource "google_project_service" "cloudapis_googleapis_com" {
  project = "107577467292"
  service = "cloudapis.googleapis.com"
}
# terraform import google_project_service.cloudapis_googleapis_com 107577467292/cloudapis.googleapis.com
