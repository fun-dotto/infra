resource "google_project_service" "artifactregistry_googleapis_com" {
  project = "107577467292"
  service = "artifactregistry.googleapis.com"
}
# terraform import google_project_service.artifactregistry_googleapis_com 107577467292/artifactregistry.googleapis.com
