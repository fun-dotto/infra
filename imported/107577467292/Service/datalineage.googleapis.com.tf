resource "google_project_service" "datalineage_googleapis_com" {
  project = "107577467292"
  service = "datalineage.googleapis.com"
}
# terraform import google_project_service.datalineage_googleapis_com 107577467292/datalineage.googleapis.com
