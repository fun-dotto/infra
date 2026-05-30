resource "google_project_service" "fcm_googleapis_com" {
  project = "107577467292"
  service = "fcm.googleapis.com"
}
# terraform import google_project_service.fcm_googleapis_com 107577467292/fcm.googleapis.com
