resource "google_project_service" "firebasestorage_googleapis_com" {
  project = "107577467292"
  service = "firebasestorage.googleapis.com"
}
# terraform import google_project_service.firebasestorage_googleapis_com 107577467292/firebasestorage.googleapis.com
