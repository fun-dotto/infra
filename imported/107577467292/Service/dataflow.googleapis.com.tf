resource "google_project_service" "dataflow_googleapis_com" {
  project = "107577467292"
  service = "dataflow.googleapis.com"
}
# terraform import google_project_service.dataflow_googleapis_com 107577467292/dataflow.googleapis.com
