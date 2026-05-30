resource "google_project_service" "eventarc_googleapis_com" {
  project = "107577467292"
  service = "eventarc.googleapis.com"
}
# terraform import google_project_service.eventarc_googleapis_com 107577467292/eventarc.googleapis.com
