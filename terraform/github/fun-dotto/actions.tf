locals {
  gcp_workload_identity_provider = "projects/107577467292/locations/global/workloadIdentityPools/dotto/providers/github"
  gcp_github_actions_sa          = "github-actions@${var.google_cloud_project_id}.iam.gserviceaccount.com"
  gcp_artifact_registry_hostname = "${var.google_cloud_region}-docker.pkg.dev"

  # Cloud Run へデプロイするリポジトリの共通 Variable
  cloud_run_deploy_variables = {
    PROJECT_ID                 = var.google_cloud_project_id
    SERVICE_ACCOUNT            = local.gcp_github_actions_sa
    WORKLOAD_IDENTITY_PROVIDER = local.gcp_workload_identity_provider
    _AR_HOSTNAME               = local.gcp_artifact_registry_hostname
    _DEPLOY_REGION             = var.google_cloud_region
  }

  # 値が null のものは Terraform 管理外 (未作成・既存値を維持) とする
  # 値を確定したら null を置き換えて管理下に入れる
  actions_variables = {
    app = {
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
    web       = local.cloud_run_deploy_variables
    admin-web = merge(local.cloud_run_deploy_variables, { PROTO_UPDATER_APP_CLIENT_ID = null })
    server    = merge(local.cloud_run_deploy_variables, { PROTO_UPDATER_APP_CLIENT_ID = null })
    infra = {
      TERRAFORM_GITHUB_APP_ID              = var.github_app_id
      TERRAFORM_GITHUB_APP_INSTALLATION_ID = var.github_app_installation_id
    }
  }

  environments = {
    web       = ["dev", "stg", "prd"]
    admin-web = ["dev", "stg", "prd"]
    server    = ["dev", "stg", "prd"]
  }

  # Firebase の Web 設定は公開値のため Secret から Variable へ移行する
  web_firebase_variables = {
    NEXT_PUBLIC_FIREBASE_API_KEY             = null
    NEXT_PUBLIC_FIREBASE_AUTH_DOMAIN         = null
    NEXT_PUBLIC_FIREBASE_PROJECT_ID          = null
    NEXT_PUBLIC_FIREBASE_STORAGE_BUCKET      = null
    NEXT_PUBLIC_FIREBASE_MESSAGING_SENDER_ID = null
    NEXT_PUBLIC_FIREBASE_APP_ID              = null
    NEXT_PUBLIC_FIREBASE_MEASUREMENT_ID      = null
    NEXT_PUBLIC_FIREBASE_APPCHECK_SITE_KEY   = null
  }

  environment_variables = {
    web = {
      dev = local.web_firebase_variables
      stg = local.web_firebase_variables
      prd = local.web_firebase_variables
    }
  }

  # GitHub Actions の Secret 名 => Secret Manager のシークレット ID
  # シークレットは terraform/google/foundation/secret-manager/github-actions.tf で作成する
  actions_secrets = {
    app = {
      ANDROID_KEYSTORE_BASE64                  = "github_actions_android_keystore_base64"
      ANDROID_KEYSTORE_PASSWORD                = "github_actions_android_keystore_password"
      APP_STORE_CONNECT_API_KEY_CONTENT_BASE64 = "github_actions_app_store_connect_api_key_content_base64"
      MATCH_GIT_APP_PRIVATE_KEY                = "github_actions_match_git_app_private_key"
      MATCH_PASSWORD                           = "github_actions_match_password"
      PROTO_UPDATER_APP_PRIVATE_KEY            = "github_actions_proto_updater_app_private_key"
      SLACK_URL                                = "github_actions_slack_url"
    }
    admin-web = {
      PROTO_UPDATER_APP_PRIVATE_KEY = "github_actions_proto_updater_app_private_key"
    }
    server = {
      PROTO_UPDATER_APP_PRIVATE_KEY = "github_actions_proto_updater_app_private_key"
    }
    infra = {
      CLOUDFLARE_API_TOKEN                = "github_actions_cloudflare_api_token"
      CLOUDFLARE_GITHUB_IDP_CLIENT_SECRET = "github_actions_cloudflare_github_idp_client_secret"
      TERRAFORM_GITHUB_APP_PRIVATE_KEY    = "github_actions_terraform_github_app_private_key"
    }
  }

  repository_environments = merge([
    for repository, environments in local.environments : {
      for environment in environments : "${repository}:${environment}" => {
        repository  = repository
        environment = environment
      }
    }
  ]...)

  repository_variables = merge([
    for repository, variables in local.actions_variables : {
      for name, value in variables : "${repository}:${name}" => {
        repository = repository
        name       = name
        value      = value
      } if value != null
    }
  ]...)

  repository_environment_variables = merge(flatten([
    for repository, environments in local.environment_variables : [
      for environment, variables in environments : {
        for name, value in variables : "${repository}:${environment}:${name}" => {
          repository  = repository
          environment = environment
          name        = name
          value       = value
        } if value != null
      }
    ]
  ])...)

  repository_secrets = merge([
    for repository, secrets in local.actions_secrets : {
      for name, secret_id in secrets : "${repository}:${name}" => {
        repository = repository
        name       = name
        secret_id  = secret_id
      }
    }
  ]...)
}

resource "github_repository_environment" "this" {
  for_each = local.repository_environments

  repository  = github_repository.this[each.value.repository].name
  environment = each.value.environment
}

resource "github_actions_variable" "this" {
  for_each = local.repository_variables

  repository    = github_repository.this[each.value.repository].name
  variable_name = each.value.name
  value         = each.value.value
}

resource "github_actions_environment_variable" "this" {
  for_each = local.repository_environment_variables

  repository    = github_repository.this[each.value.repository].name
  environment   = github_repository_environment.this["${each.value.repository}:${each.value.environment}"].environment
  variable_name = each.value.name
  value         = each.value.value
}

data "google_secret_manager_secret_version" "actions_secrets" {
  for_each = toset(values(local.repository_secrets)[*].secret_id)

  secret = each.value
}

# 値は tfstate (GCS) に平文で保存される
resource "github_actions_secret" "this" {
  for_each = local.repository_secrets

  repository      = github_repository.this[each.value.repository].name
  secret_name     = each.value.name
  plaintext_value = data.google_secret_manager_secret_version.actions_secrets[each.value.secret_id].secret_data
}
