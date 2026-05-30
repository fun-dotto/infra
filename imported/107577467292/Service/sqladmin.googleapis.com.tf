resource "google_project_service" "sqladmin_googleapis_com" {
  project = "107577467292"
  service = "sqladmin.googleapis.com"
}
# terraform import google_project_service.sqladmin_googleapis_com 107577467292/sqladmin.googleapis.com
