locals {
  app_variables = {
    GCP_SERVICE_ACCOUNT            = local.gcp_github_actions_sa
    GCP_WORKLOAD_IDENTITY_PROVIDER = local.gcp_workload_identity_provider
    FIREBASE_APP_ID_ANDROID_DEV    = "1:107577467292:android:e07ef0167a67daf106e859"
    FIREBASE_APP_ID_ANDROID_STG    = "1:107577467292:android:99fa38c96f4496aa06e859"
    FIREBASE_APP_ID_ANDROID_PRD    = "1:107577467292:android:fbc3e8fc5e706c0906e859"
    FIREBASE_APP_ID_IOS_DEV        = "1:107577467292:ios:af2df46aff3df68506e859"
    FIREBASE_APP_ID_IOS_STG        = "1:107577467292:ios:b60af28764a55b0a06e859"
    FIREBASE_APP_ID_IOS_PRD        = "1:107577467292:ios:db9fcaa9ded4130706e859"
    # Secret から Variable へ移行するもの
    ANDROID_OTA_KEY_ALIAS               = null
    ANDROID_RELEASE_KEY_ALIAS           = null
    APP_STORE_CONNECT_API_KEY_ID        = null
    APP_STORE_CONNECT_API_KEY_ISSUER_ID = null
    # 既存の Variable
    FIREBASE_APP_DISTRIBUTION_GROUPS = null
    MATCH_GIT_APP_ID                 = null
    PROTO_UPDATER_APP_CLIENT_ID      = null
  }
}

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

  variables = local.app_variables

  secrets = [
    "ANDROID_KEYSTORE_BASE64",
    "ANDROID_KEYSTORE_PASSWORD",
    "APP_STORE_CONNECT_API_KEY_CONTENT_BASE64",
    "MATCH_GIT_APP_PRIVATE_KEY",
    "MATCH_PASSWORD",
    "PROTO_UPDATER_APP_PRIVATE_KEY",
    "SLACK_URL",
  ]
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

import {
  for_each = { for k, v in local.app_variables : k => v if v != null }
  to       = module.app.github_actions_variable.this[each.key]
  id       = "app:${each.key}"
}
