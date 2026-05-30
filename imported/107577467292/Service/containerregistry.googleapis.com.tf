resource "google_project_service" "containerregistry_googleapis_com" {
  project = "107577467292"
  service = "containerregistry.googleapis.com"
}
# terraform import google_project_service.containerregistry_googleapis_com 107577467292/containerregistry.googleapis.com
