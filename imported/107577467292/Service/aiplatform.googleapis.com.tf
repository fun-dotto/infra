resource "google_project_service" "aiplatform_googleapis_com" {
  project = "107577467292"
  service = "aiplatform.googleapis.com"
}
# terraform import google_project_service.aiplatform_googleapis_com 107577467292/aiplatform.googleapis.com
