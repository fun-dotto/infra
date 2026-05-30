resource "google_project_service" "bigquery_googleapis_com" {
  project = "107577467292"
  service = "bigquery.googleapis.com"
}
# terraform import google_project_service.bigquery_googleapis_com 107577467292/bigquery.googleapis.com
