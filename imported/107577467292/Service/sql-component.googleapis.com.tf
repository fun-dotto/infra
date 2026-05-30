resource "google_project_service" "sql_component_googleapis_com" {
  project = "107577467292"
  service = "sql-component.googleapis.com"
}
# terraform import google_project_service.sql_component_googleapis_com 107577467292/sql-component.googleapis.com
