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
}
