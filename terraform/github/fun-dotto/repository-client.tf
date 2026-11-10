module "client" {
  source = "../../modules/github-repository"

  name         = "client"
  description  = "公立はこだて未来大学ポータルアプリ Dotto クライアント"
  homepage_url = "https://fun-dotto.com"
  topics       = []

  ruleset = {
    merge_method               = "merge"
    required_approving_reviews = 0
    required_reviewers         = [{ team_id = github_team.this["masters"].id, minimum_approvals = 1 }]
    required_status_checks     = ["check", "typecheck", "test"]
  }
}
