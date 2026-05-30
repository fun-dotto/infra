resource "google_project_service" "dataform_googleapis_com" {
  project = "107577467292"
  service = "dataform.googleapis.com"
}
# terraform import google_project_service.dataform_googleapis_com 107577467292/dataform.googleapis.com
