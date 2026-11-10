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
      reviewer_user_ids = [
        51151242,  # kantacky
        135803012, # hikaru-0602
        136790650, # masaya-osuga
      ]
      protected_branches_only = true
      prevent_self_review     = true
      can_admins_bypass       = false
    }
  }

  workload_identity_roles = [
    "roles/artifactregistry.writer",
    "roles/iam.serviceAccountUser", # Cloud Run に実行 SA を設定するため
    "roles/run.developer",
  ]
}
