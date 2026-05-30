resource "google_project_service" "appengine_googleapis_com" {
  project = "107577467292"
  service = "appengine.googleapis.com"
}
# terraform import google_project_service.appengine_googleapis_com 107577467292/appengine.googleapis.com
