resource "google_project_service" "firestore_googleapis_com" {
  project = "107577467292"
  service = "firestore.googleapis.com"
}
# terraform import google_project_service.firestore_googleapis_com 107577467292/firestore.googleapis.com
