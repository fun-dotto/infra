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
