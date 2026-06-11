resource "google_service_account" "firebase_app_distribution" {
  account_id   = "firebase-app-distribution"
  description  = "Firebase App Distribution"
  display_name = "Firebase App Distribution"
}

resource "google_project_iam_member" "firebase_app_distribution" {
  for_each = toset([
    "roles/firebase.appDistributionSdkServiceAgent",
  ])

  project = var.google_cloud_project_id
  role    = each.value
  member  = "serviceAccount:${google_service_account.firebase_app_distribution.email}"
}
