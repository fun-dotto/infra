locals {
  server_variables = merge(local.cloud_run_deploy_variables, { PROTO_UPDATER_APP_CLIENT_ID = null })
}

module "server" {
  source = "../../modules/github-repository"

  name         = "server"
  description  = "Dotto サーバー"
  homepage_url = ""
  topics       = []

  ruleset = {
    merge_method               = "squash"
    required_approving_reviews = 1
    required_reviewers         = [{ team_id = github_team.this["masters"].id, minimum_approvals = 1 }]
    required_status_checks     = ["Test", "Lint", "Build"]
  }

  team_permissions = {
    masters = { team_id = github_team.this["masters"].id, permission = "admin" }
    server  = { team_id = github_team.this["server"].id, permission = "push" }
  }

  environments = ["dev", "stg", "prd"]

  variables = local.server_variables

  secrets = [
    "PROTO_UPDATER_APP_PRIVATE_KEY",
  ]

  workload_identity_roles = [
    "roles/artifactregistry.writer",
    "roles/iam.serviceAccountUser", # Cloud Run に実行 SA を設定するため
    "roles/run.developer",
  ]
}

moved {
  from = github_repository.this["server"]
  to   = module.server.github_repository.this
}

moved {
  from = github_repository_ruleset.default_branch["server"]
  to   = module.server.github_repository_ruleset.default_branch
}

moved {
  from = github_team_repository.this["masters:server"]
  to   = module.server.github_team_repository.this["masters"]
}

moved {
  from = github_team_repository.this["server:server"]
  to   = module.server.github_team_repository.this["server"]
}

import {
  for_each = toset(["dev", "stg", "prd"])
  to       = module.server.github_repository_environment.this[each.key]
  id       = "server:${each.key}"
}

import {
  for_each = { for k, v in local.server_variables : k => v if v != null }
  to       = module.server.github_actions_variable.this[each.key]
  id       = "server:${each.key}"
}
