resource "google_project_service" "oslogin_googleapis_com" {
  project = "107577467292"
  service = "oslogin.googleapis.com"
}
# terraform import google_project_service.oslogin_googleapis_com 107577467292/oslogin.googleapis.com
