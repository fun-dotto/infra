# Compute Engine デフォルト SA は Google 管理のため、ロール付与のみ管理する
data "google_project" "this" {}

locals {
  compute_default_member = "serviceAccount:${data.google_project.this.number}-compute@developer.gserviceaccount.com"

  compute_default_roles = toset([
    "roles/firebaseauth.admin",
    "roles/firebasedatabase.admin",
  ])
}

resource "google_project_iam_member" "compute_default" {
  for_each = local.compute_default_roles

  project = var.google_cloud_project_id
  role    = each.value
  member  = local.compute_default_member
}

import {
  for_each = local.compute_default_roles

  to = google_project_iam_member.compute_default[each.value]
  id = "${var.google_cloud_project_id} ${each.value} serviceAccount:107577467292-compute@developer.gserviceaccount.com"
}
