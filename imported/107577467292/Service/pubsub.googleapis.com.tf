resource "google_project_service" "pubsub_googleapis_com" {
  project = "107577467292"
  service = "pubsub.googleapis.com"
}
# terraform import google_project_service.pubsub_googleapis_com 107577467292/pubsub.googleapis.com
