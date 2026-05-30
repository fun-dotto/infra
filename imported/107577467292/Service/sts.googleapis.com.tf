resource "google_project_service" "sts_googleapis_com" {
  project = "107577467292"
  service = "sts.googleapis.com"
}
# terraform import google_project_service.sts_googleapis_com 107577467292/sts.googleapis.com
