locals {
  # GitHub Actions の App ID
  github_actions_integration_id = 15368

  variables = { for name, value in var.variables : name => value if value != null }

  environment_variables = merge([
    for environment, variables in var.environment_variables : {
      for name, value in variables : "${environment}:${name}" => {
        environment = environment
        name        = name
        value       = value
      } if value != null
    }
  ]...)
}

resource "github_repository" "this" {
  name         = var.name
  description  = var.description
  homepage_url = var.homepage_url
  topics       = var.topics
  visibility   = "public"

  has_issues      = true
  has_projects    = true
  has_wiki        = var.has_wiki
  has_discussions = false

  allow_merge_commit          = var.allow_merge_commit
  allow_squash_merge          = true
  allow_rebase_merge          = true
  allow_auto_merge            = var.allow_auto_merge
  allow_update_branch         = true
  delete_branch_on_merge      = true
  squash_merge_commit_title   = "COMMIT_OR_PR_TITLE"
  squash_merge_commit_message = "COMMIT_MESSAGES"
  merge_commit_title          = "MERGE_MESSAGE"
  merge_commit_message        = "PR_TITLE"
  web_commit_signoff_required = false

  archive_on_destroy = true

  lifecycle {
    prevent_destroy = true
  }
}

resource "github_repository_ruleset" "default_branch" {
  repository  = github_repository.this.name
  name        = var.ruleset.name
  target      = "branch"
  enforcement = "active"

  conditions {
    ref_name {
      include = ["~DEFAULT_BRANCH"]
      exclude = []
    }
  }

  rules {
    deletion         = true
    non_fast_forward = true

    pull_request {
      allowed_merge_methods             = [var.ruleset.merge_method]
      dismiss_stale_reviews_on_push     = var.ruleset.dismiss_stale_reviews
      require_code_owner_review         = false
      require_last_push_approval        = false
      required_approving_review_count   = var.ruleset.required_approving_reviews
      required_review_thread_resolution = false

      dynamic "required_reviewers" {
        for_each = var.ruleset.required_reviewers
        content {
          file_patterns     = ["*"]
          minimum_approvals = required_reviewers.value.minimum_approvals
          reviewer {
            id   = required_reviewers.value.team_id
            type = "Team"
          }
        }
      }
    }

    dynamic "required_status_checks" {
      for_each = length(var.ruleset.required_status_checks) > 0 ? [1] : []
      content {
        do_not_enforce_on_create             = false
        strict_required_status_checks_policy = false

        dynamic "required_check" {
          for_each = var.ruleset.required_status_checks
          content {
            context        = required_check.value
            integration_id = local.github_actions_integration_id
          }
        }
      }
    }

    merge_queue {
      check_response_timeout_minutes    = 60
      grouping_strategy                 = "ALLGREEN"
      max_entries_to_build              = var.ruleset.max_entries_to_build
      max_entries_to_merge              = 5
      merge_method                      = upper(var.ruleset.merge_method)
      min_entries_to_merge              = 1
      min_entries_to_merge_wait_minutes = 5
    }
  }

  # 既存の bypass は User（kantacky）だが provider が actor_type = "User" に未対応のため、コンソール管理とする
  lifecycle {
    ignore_changes = [bypass_actors]
  }
}

resource "github_team_repository" "this" {
  for_each = var.team_permissions

  team_id    = each.value.team_id
  repository = github_repository.this.name
  permission = each.value.permission
}

resource "github_repository_environment" "this" {
  for_each = toset(var.environments)

  repository  = github_repository.this.name
  environment = each.value
}

resource "github_actions_variable" "this" {
  for_each = local.variables

  repository    = github_repository.this.name
  variable_name = each.key
  value         = each.value
}

resource "github_actions_environment_variable" "this" {
  for_each = local.environment_variables

  repository    = github_repository.this.name
  environment   = github_repository_environment.this[each.value.environment].environment
  variable_name = each.value.name
  value         = each.value.value
}

data "google_secret_manager_secret_version" "secrets" {
  for_each = toset(values(var.secrets))

  secret = each.value
}

# 値は tfstate に平文で保存される
resource "github_actions_secret" "this" {
  for_each = var.secrets

  repository      = github_repository.this.name
  secret_name     = each.key
  plaintext_value = data.google_secret_manager_secret_version.secrets[each.value].secret_data
}
