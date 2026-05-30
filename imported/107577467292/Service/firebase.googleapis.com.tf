resource "google_project_service" "firebase_googleapis_com" {
  project = "107577467292"
  service = "firebase.googleapis.com"
}
# terraform import google_project_service.firebase_googleapis_com 107577467292/firebase.googleapis.com
