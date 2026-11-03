module "app" {
  source = "../../modules/github-repository"

  name         = "app"
  description  = "公立はこだて未来大学ポータルアプリ Dotto モバイルアプリ"
  homepage_url = "https://fun-dotto.com"
  topics       = ["app"]

  ruleset = {
    merge_method               = "squash"
    required_approving_reviews = 1
    required_reviewers         = [{ team_id = github_team.this["masters"].id, minimum_approvals = 1 }]
    required_status_checks     = ["Test", "Lint"]
  }

  team_permissions = {
    app     = { team_id = github_team.this["app"].id, permission = "push" }
    masters = { team_id = github_team.this["masters"].id, permission = "admin" }
  }

}

moved {
  from = github_repository.this["app"]
  to   = module.app.github_repository.this
}

moved {
  from = github_repository_ruleset.default_branch["app"]
  to   = module.app.github_repository_ruleset.default_branch
}

moved {
  from = github_team_repository.this["app:app"]
  to   = module.app.github_team_repository.this["app"]
}

moved {
  from = github_team_repository.this["masters:app"]
  to   = module.app.github_team_repository.this["masters"]
}
