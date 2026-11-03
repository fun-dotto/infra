locals {
  admin_web_variables = merge(local.cloud_run_deploy_variables, { PROTO_UPDATER_APP_CLIENT_ID = null })
}

module "admin_web" {
  source = "../../modules/github-repository"

  name         = "admin-web"
  description  = "Dotto Admin"
  homepage_url = "https://admin.fun-dotto.com"
  topics       = []

  ruleset = {
    merge_method               = "squash"
    required_approving_reviews = 1
    required_reviewers         = [{ team_id = github_team.this["masters"].id, minimum_approvals = 1 }]
    required_status_checks     = []
  }

  team_permissions = {
    app    = { team_id = github_team.this["app"].id, permission = "pull" }
    server = { team_id = github_team.this["server"].id, permission = "push" }
    web    = { team_id = github_team.this["web"].id, permission = "pull" }
  }

  environments = ["dev", "stg", "prd"]

  variables = local.admin_web_variables

  secrets = {
    PROTO_UPDATER_APP_PRIVATE_KEY = "github_actions_proto_updater_app_private_key"
  }
}

moved {
  from = github_repository.this["admin-web"]
  to   = module.admin_web.github_repository.this
}

moved {
  from = github_repository_ruleset.default_branch["admin-web"]
  to   = module.admin_web.github_repository_ruleset.default_branch
}

moved {
  from = github_team_repository.this["app:admin-web"]
  to   = module.admin_web.github_team_repository.this["app"]
}

moved {
  from = github_team_repository.this["server:admin-web"]
  to   = module.admin_web.github_team_repository.this["server"]
}

moved {
  from = github_team_repository.this["web:admin-web"]
  to   = module.admin_web.github_team_repository.this["web"]
}

import {
  for_each = toset(["dev", "stg", "prd"])
  to       = module.admin_web.github_repository_environment.this[each.key]
  id       = "admin-web:${each.key}"
}

import {
  for_each = { for k, v in local.admin_web_variables : k => v if v != null }
  to       = module.admin_web.github_actions_variable.this[each.key]
  id       = "admin-web:${each.key}"
}
