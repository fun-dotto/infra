locals {
  group_project_roles = {
    "fun-dotto-dev-server@googlegroups.com" = [
      "roles/cloudsql.client",
      "roles/cloudsql.instanceUser",
      "roles/logging.viewer",
    ]
    "fun-dotto-dev-app@googlegroups.com" = [
      "roles/firebase.viewer",
    ]
    "fun-dotto-dev-web@googlegroups.com" = [
      "roles/firebase.viewer",
    ]
  }

  group_project_role_members = merge([
    for group, roles in local.group_project_roles : {
      for role in roles : "${group} ${role}" => { group = group, role = role }
    }
  ]...)
}

resource "google_project_iam_member" "group" {
  for_each = local.group_project_role_members

  project = var.google_cloud_project_id
  role    = each.value.role
  member  = "group:${each.value.group}"
}

import {
  for_each = local.group_project_role_members

  to = google_project_iam_member.group[each.key]
  id = "${var.google_cloud_project_id} ${each.value.role} group:${each.value.group}"
}
