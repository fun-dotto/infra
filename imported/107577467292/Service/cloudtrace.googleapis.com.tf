resource "google_project_service" "cloudtrace_googleapis_com" {
  project = "107577467292"
  service = "cloudtrace.googleapis.com"
}
# terraform import google_project_service.cloudtrace_googleapis_com 107577467292/cloudtrace.googleapis.com
