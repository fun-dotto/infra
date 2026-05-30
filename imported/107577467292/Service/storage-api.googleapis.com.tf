resource "google_project_service" "storage_api_googleapis_com" {
  project = "107577467292"
  service = "storage-api.googleapis.com"
}
# terraform import google_project_service.storage_api_googleapis_com 107577467292/storage-api.googleapis.com
