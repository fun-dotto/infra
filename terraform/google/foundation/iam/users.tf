locals {
  user_project_roles = {
    "dotto@fun.ac.jp" = [
      "roles/owner",
    ]
    "iam@kantacky.com" = [
      "roles/admin",
    ]
    "ictfun2022@gmail.com" = [
      "roles/billing.projectManager",
    ]
    "satoru2001130830@gmail.com" = [
      "roles/firebase.developAdmin",
    ]
  }

  # import ブロック導入後に追加したメンバー（既存リソースが無いので import 対象外）
  user_project_role_members_not_imported = [
    "satoru2001130830@gmail.com roles/firebase.developAdmin",
  ]

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
  for_each = {
    for k, v in local.user_project_role_members : k => v
    if !contains(local.user_project_role_members_not_imported, k)
  }

  to = google_project_iam_member.user[each.key]
  id = "${var.google_cloud_project_id} ${each.value.role} user:${each.value.user}"
}
