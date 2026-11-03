# Firebase が自動作成した Admin SDK 用 SA
resource "google_service_account" "firebase_adminsdk" {
  account_id   = "firebase-adminsdk-v653f"
  display_name = "firebase-adminsdk"
  description  = "Firebase Admin SDK Service Agent"
}

import {
  to = google_service_account.firebase_adminsdk
  id = "projects/${var.google_cloud_project_id}/serviceAccounts/firebase-adminsdk-v653f@${var.google_cloud_project_id}.iam.gserviceaccount.com"
}

locals {
  firebase_adminsdk_roles = toset([
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
}

resource "google_project_iam_member" "firebase_adminsdk" {
  for_each = local.firebase_adminsdk_roles

  project = var.google_cloud_project_id
  role    = each.value
  member  = "serviceAccount:${google_service_account.firebase_adminsdk.email}"
}

import {
  for_each = local.firebase_adminsdk_roles

  to = google_project_iam_member.firebase_adminsdk[each.value]
  id = "${var.google_cloud_project_id} ${each.value} serviceAccount:firebase-adminsdk-v653f@${var.google_cloud_project_id}.iam.gserviceaccount.com"
}
