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
  for_each = toset(var.environments)

  repository  = github_repository.this.name
  environment = each.value
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
