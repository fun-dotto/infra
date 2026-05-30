resource "google_project_service" "networkmanagement_googleapis_com" {
  project = "107577467292"
  service = "networkmanagement.googleapis.com"
}
# terraform import google_project_service.networkmanagement_googleapis_com 107577467292/networkmanagement.googleapis.com
