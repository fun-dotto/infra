locals {
  infra_variables = {
    TERRAFORM_GITHUB_APP_ID              = var.github_app_id
    TERRAFORM_GITHUB_APP_INSTALLATION_ID = var.github_app_installation_id
  }
}

module "infra" {
  source = "../../modules/github-repository"

  name         = "infra"
  description  = "Dotto インフラ"
  homepage_url = ""
  topics       = []

  # required_approving_reviews = 1, required_reviewers = masters に戻す予定
  ruleset = {
    merge_method               = "squash"
    required_approving_reviews = 0
    required_reviewers         = []
    required_status_checks     = ["Format", "Validate"]
  }

  team_permissions = {
    app     = { team_id = github_team.this["app"].id, permission = "push" }
    masters = { team_id = github_team.this["masters"].id, permission = "admin" }
    server  = { team_id = github_team.this["server"].id, permission = "push" }
    web     = { team_id = github_team.this["web"].id, permission = "push" }
  }

  variables = local.infra_variables

  secrets = {
    CLOUDFLARE_API_TOKEN                = "github_actions_cloudflare_api_token"
    CLOUDFLARE_GITHUB_IDP_CLIENT_SECRET = "github_actions_cloudflare_github_idp_client_secret"
    TERRAFORM_GITHUB_APP_PRIVATE_KEY    = "github_actions_terraform_github_app_private_key"
  }
}

moved {
  from = github_repository.this["infra"]
  to   = module.infra.github_repository.this
}

moved {
  from = github_repository_ruleset.default_branch["infra"]
  to   = module.infra.github_repository_ruleset.default_branch
}

moved {
  from = github_team_repository.this["app:infra"]
  to   = module.infra.github_team_repository.this["app"]
}

moved {
  from = github_team_repository.this["masters:infra"]
  to   = module.infra.github_team_repository.this["masters"]
}

moved {
  from = github_team_repository.this["server:infra"]
  to   = module.infra.github_team_repository.this["server"]
}

moved {
  from = github_team_repository.this["web:infra"]
  to   = module.infra.github_team_repository.this["web"]
}

import {
  for_each = { for k, v in local.infra_variables : k => v if v != null }
  to       = module.infra.github_actions_variable.this[each.key]
  id       = "infra:${each.key}"
}
