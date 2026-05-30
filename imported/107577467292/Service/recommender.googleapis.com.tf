resource "google_project_service" "recommender_googleapis_com" {
  project = "107577467292"
  service = "recommender.googleapis.com"
}
# terraform import google_project_service.recommender_googleapis_com 107577467292/recommender.googleapis.com
