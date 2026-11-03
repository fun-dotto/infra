locals {
  # dotto@fun.ac.jp・iam@kantacky.com はプロジェクト管理者のため Terraform で管理しない
  user_project_roles = {
    "ictfun2022@gmail.com" = [
      "roles/billing.projectManager",
    ]
  }

  user_project_role_members = merge([
    for user, roles in local.user_project_roles : {
      for role in roles : "${user} ${role}" => { user = user, role = role }
    }
  ]...)
}

resource "google_project_iam_member" "user" {
  for_each = local.user_project_role_members

  project = var.google_cloud_project_id
  role    = each.value.role
  member  = "user:${each.value.user}"
}

import {
  for_each = local.user_project_role_members

  to = google_project_iam_member.user[each.key]
  id = "${var.google_cloud_project_id} ${each.value.role} user:${each.value.user}"
}
