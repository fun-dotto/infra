resource "google_service_account" "class_change_batch_job" {
  account_id   = "class-change-batch-job"
  display_name = "Class Change Batch Cloud Run Job"
}

import {
  to = google_service_account.class_change_batch_job
  id = "projects/${var.google_cloud_project_id}/serviceAccounts/class-change-batch-job@${var.google_cloud_project_id}.iam.gserviceaccount.com"
}

locals {
  class_change_batch_job_roles = toset([
    "roles/cloudsql.client",
    "roles/cloudsql.instanceUser",
  ])
}

resource "google_project_iam_member" "class_change_batch_job" {
  for_each = local.class_change_batch_job_roles

  project = var.google_cloud_project_id
  role    = each.value
  member  = "serviceAccount:${google_service_account.class_change_batch_job.email}"
}

import {
  for_each = local.class_change_batch_job_roles

  to = google_project_iam_member.class_change_batch_job[each.value]
  id = "${var.google_cloud_project_id} ${each.value} serviceAccount:class-change-batch-job@${var.google_cloud_project_id}.iam.gserviceaccount.com"
}

resource "google_service_account" "class_change_batch_scheduler" {
  account_id   = "class-change-batch-scheduler"
  display_name = "Class Change Batch Cloud Scheduler"
}

import {
  to = google_service_account.class_change_batch_scheduler
  id = "projects/${var.google_cloud_project_id}/serviceAccounts/class-change-batch-scheduler@${var.google_cloud_project_id}.iam.gserviceaccount.com"
}
