resource "github_repository_environment" "this" {
  for_each = var.environments

  repository        = github_repository.this.name
  environment       = each.key
  can_admins_bypass = each.value.can_admins_bypass

  dynamic "reviewers" {
    for_each = length(each.value.reviewer_user_ids) > 0 ? [1] : []
    content {
      users = each.value.reviewer_user_ids
    }
  }

  dynamic "deployment_branch_policy" {
    for_each = each.value.protected_branches_only ? [1] : []
    content {
      protected_branches     = true
      custom_branch_policies = false
    }
  }
}
