locals {
  variables = { for name, value in var.variables : name => value if value != null }

  environment_variables = merge([
    for environment, variables in var.environment_variables : {
      for name, value in variables : "${environment}:${name}" => {
        environment = environment
        name        = name
        value       = value
      } if value != null
    }
  ]...)
}

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

resource "github_actions_variable" "this" {
  for_each = local.variables

  repository    = github_repository.this.name
  variable_name = each.key
  value         = each.value
}

resource "github_actions_environment_variable" "this" {
  for_each = local.environment_variables

  repository    = github_repository.this.name
  environment   = github_repository_environment.this[each.value.environment].environment
  variable_name = each.value.name
  value         = each.value.value
}
