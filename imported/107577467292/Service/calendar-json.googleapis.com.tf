resource "google_project_service" "calendar_json_googleapis_com" {
  project = "107577467292"
  service = "calendar-json.googleapis.com"
}
# terraform import google_project_service.calendar_json_googleapis_com 107577467292/calendar-json.googleapis.com
