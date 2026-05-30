resource "google_project_service" "securetoken_googleapis_com" {
  project = "107577467292"
  service = "securetoken.googleapis.com"
}
# terraform import google_project_service.securetoken_googleapis_com 107577467292/securetoken.googleapis.com
