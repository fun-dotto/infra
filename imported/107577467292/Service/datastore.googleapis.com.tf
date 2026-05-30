resource "google_project_service" "datastore_googleapis_com" {
  project = "107577467292"
  service = "datastore.googleapis.com"
}
# terraform import google_project_service.datastore_googleapis_com 107577467292/datastore.googleapis.com
