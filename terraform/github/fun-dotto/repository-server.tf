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
    required_status_checks = [
      "Test",
      "Lint",
      "Build",
      "Migration Validate",
      # migrate.yml の matrix ジョブのチェック名は "<ジョブ名> (<environment>, <database_name>)"
      "Migration Dry Run (dev, dotto_dev)",
      "Migration Dry Run (stg, dotto_stg)",
      "Migration Dry Run (prd, dotto)",
    ]
  }

  team_permissions = {
    masters = { team_id = github_team.this["masters"].id, permission = "admin" }
    server  = { team_id = github_team.this["server"].id, permission = "push" }
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
