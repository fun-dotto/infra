# Firebase の API は Federated Identity のトークンを受け付けないため、SA を借用する。
provider "google-beta" {
  alias                       = "firebase"
  billing_project             = var.google_cloud_project_id
  project                     = var.google_cloud_project_id
  region                      = var.google_cloud_region
  user_project_override       = true
  impersonate_service_account = "terraform-firebase@${var.google_cloud_project_id}.iam.gserviceaccount.com"
}
