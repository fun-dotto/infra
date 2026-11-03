locals {
  # GitHub Actions の App ID
  github_actions_integration_id = 15368
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
