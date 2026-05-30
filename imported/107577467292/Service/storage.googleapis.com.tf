resource "google_project_service" "storage_googleapis_com" {
  project = "107577467292"
  service = "storage.googleapis.com"
}
# terraform import google_project_service.storage_googleapis_com 107577467292/storage.googleapis.com
