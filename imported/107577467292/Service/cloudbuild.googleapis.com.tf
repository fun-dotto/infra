resource "google_project_service" "cloudbuild_googleapis_com" {
  project = "107577467292"
  service = "cloudbuild.googleapis.com"
}
# terraform import google_project_service.cloudbuild_googleapis_com 107577467292/cloudbuild.googleapis.com
