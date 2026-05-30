resource "google_project_service" "iam_googleapis_com" {
  project = "107577467292"
  service = "iam.googleapis.com"
}
# terraform import google_project_service.iam_googleapis_com 107577467292/iam.googleapis.com
