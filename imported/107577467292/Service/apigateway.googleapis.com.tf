resource "google_project_service" "apigateway_googleapis_com" {
  project = "107577467292"
  service = "apigateway.googleapis.com"
}
# terraform import google_project_service.apigateway_googleapis_com 107577467292/apigateway.googleapis.com
