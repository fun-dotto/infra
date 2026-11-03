locals {
  web_variables = local.cloud_run_deploy_variables

  web_environment_variables = {
    dev = local.web_firebase_variables
    stg = local.web_firebase_variables
    prd = local.web_firebase_variables
  }
}

module "web" {
  source = "../../modules/github-repository"

  name         = "web"
  description  = "公立はこだて未来大学ポータルアプリ Dotto Webアプリ"
  homepage_url = "https://fun-dotto.com"
  topics       = []

  ruleset = {
    merge_method               = "squash"
    required_approving_reviews = 1
    required_reviewers         = [{ team_id = github_team.this["masters"].id, minimum_approvals = 1 }]
    required_status_checks     = ["Lint", "Build"]
  }

  team_permissions = {
    masters = { team_id = github_team.this["masters"].id, permission = "admin" }
    web     = { team_id = github_team.this["web"].id, permission = "push" }
  }

  environments = {
    dev = {}
    stg = {}
    prd = {
      reviewer_user_ids       = [51151242, 135803012, 136790650]
      protected_branches_only = true
      can_admins_bypass       = false
    }
  }

  variables = local.web_variables

  environment_variables = local.web_environment_variables

  workload_identity_roles = [
    "roles/artifactregistry.writer",
    "roles/iam.serviceAccountUser", # Cloud Run に実行 SA を設定するため
    "roles/run.developer",
  ]
}

moved {
  from = github_repository.this["web"]
  to   = module.web.github_repository.this
}

moved {
  from = github_repository_ruleset.default_branch["web"]
  to   = module.web.github_repository_ruleset.default_branch
}

moved {
  from = github_team_repository.this["masters:web"]
  to   = module.web.github_team_repository.this["masters"]
}

moved {
  from = github_team_repository.this["web:web"]
  to   = module.web.github_team_repository.this["web"]
}

import {
  for_each = toset(["dev", "stg", "prd"])
  to       = module.web.github_repository_environment.this[each.key]
  id       = "web:${each.key}"
}

import {
  for_each = { for k, v in local.web_variables : k => v if v != null }
  to       = module.web.github_actions_variable.this[each.key]
  id       = "web:${each.key}"
}
