resource "google_project_service" "compute_googleapis_com" {
  project = "107577467292"
  service = "compute.googleapis.com"
}
# terraform import google_project_service.compute_googleapis_com 107577467292/compute.googleapis.com
