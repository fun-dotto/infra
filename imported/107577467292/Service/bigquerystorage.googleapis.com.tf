resource "google_project_service" "bigquerystorage_googleapis_com" {
  project = "107577467292"
  service = "bigquerystorage.googleapis.com"
}
# terraform import google_project_service.bigquerystorage_googleapis_com 107577467292/bigquerystorage.googleapis.com
