resource "google_service_account" "firebase_adminsdk_v653f" {
  account_id   = "firebase-adminsdk-v653f"
  description  = "Firebase Admin SDK Service Agent"
  display_name = "firebase-adminsdk"
}

resource "google_project_iam_member" "firebase_adminsdk_v653f" {
  for_each = toset([
    "roles/cloudconfig.admin",
    "roles/cloudfunctions.admin",
    "roles/firebase.analyticsAdmin",
    "roles/firebase.appDistributionSdkServiceAgent",
    "roles/firebase.sdkAdminServiceAgent",
    "roles/firebaseabt.admin",
    "roles/firebaseappcheck.admin",
    "roles/firebaseauth.admin",
    "roles/firebasedatabase.admin",
    "roles/iam.serviceAccountTokenCreator",
    "roles/storage.admin",
  ])

  project = var.google_cloud_project_id
  role    = each.value
  member  = "serviceAccount:${google_service_account.firebase_adminsdk_v653f.email}"
}
