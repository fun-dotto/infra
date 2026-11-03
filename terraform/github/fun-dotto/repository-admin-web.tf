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

  environments = {
    dev = {}
    stg = {}
    prd = {
      reviewer_user_ids = [
        51151242,  # kantacky
        135803012, # hikaru-0602
        136790650, # masaya-osuga
      ]
      protected_branches_only = true
    }
  }

  workload_identity_roles = [
    "roles/artifactregistry.writer",
    "roles/iam.serviceAccountUser", # Cloud Run に実行 SA を設定するため
    "roles/run.developer",
  ]
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
