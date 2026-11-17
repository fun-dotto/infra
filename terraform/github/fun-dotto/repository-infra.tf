module "infra" {
  source = "../../modules/github-repository"

  name         = "infra"
  description  = "Dotto インフラ"
  homepage_url = ""
  topics       = []

  ruleset = {
    merge_method               = "squash"
    required_approving_reviews = 1
    required_reviewers         = [{ team_id = github_team.this["masters"].id, minimum_approvals = 1 }]
    required_status_checks     = ["Format", "Validate"]
    # Digger でマージ前に apply するため、マージキューで再検証する意味がない。
    # 代わりに main の変更を取り込んだ状態で plan / apply させる
    merge_queue                   = false
    strict_required_status_checks = true
  }

  team_permissions = {
    app     = { team_id = github_team.this["app"].id, permission = "push" }
    masters = { team_id = github_team.this["masters"].id, permission = "admin" }
    server  = { team_id = github_team.this["server"].id, permission = "push" }
    web     = { team_id = github_team.this["web"].id, permission = "push" }
  }
}
