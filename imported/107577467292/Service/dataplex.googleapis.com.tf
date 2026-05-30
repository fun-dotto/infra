resource "google_project_service" "dataplex_googleapis_com" {
  project = "107577467292"
  service = "dataplex.googleapis.com"
}
# terraform import google_project_service.dataplex_googleapis_com 107577467292/dataplex.googleapis.com
