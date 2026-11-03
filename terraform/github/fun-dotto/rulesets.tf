locals {
  # merge_queue は全リポジトリで共通。client だけ merge commit を使う
  rulesets = {
    app = {
      name                       = "default"
      merge_method               = "squash"
      required_approving_reviews = 1
      dismiss_stale_reviews      = false
      max_entries_to_build       = 10
      required_reviewers         = [{ team = "app", minimum_approvals = 1 }, { team = "masters", minimum_approvals = 1 }]
      required_status_checks     = ["Test", "Lint"]
    }
    web = {
      name                       = "Default"
      merge_method               = "squash"
      required_approving_reviews = 1
      dismiss_stale_reviews      = false
      max_entries_to_build       = 5
      required_reviewers         = [{ team = "masters", minimum_approvals = 1 }, { team = "web", minimum_approvals = 0 }]
      required_status_checks     = ["Lint", "Build"]
    }
    admin-web = {
      name                       = "default"
      merge_method               = "squash"
      required_approving_reviews = 1
      dismiss_stale_reviews      = false
      max_entries_to_build       = 5
      required_reviewers         = [{ team = "web", minimum_approvals = 0 }, { team = "masters", minimum_approvals = 1 }]
      required_status_checks     = []
    }
    client = {
      name                       = "Default"
      merge_method               = "merge"
      required_approving_reviews = 0
      dismiss_stale_reviews      = false
      max_entries_to_build       = 5
      required_reviewers         = []
      required_status_checks     = ["check", "typecheck", "test"]
    }
    server = {
      name                       = "Default"
      merge_method               = "squash"
      required_approving_reviews = 1
      dismiss_stale_reviews      = false
      max_entries_to_build       = 5
      required_reviewers         = [{ team = "masters", minimum_approvals = 1 }, { team = "server", minimum_approvals = 0 }]
      required_status_checks     = ["Test", "Lint", "Build"]
    }
    infra = {
      name                       = "Default"
      merge_method               = "squash"
      required_approving_reviews = 0
      dismiss_stale_reviews      = true
      max_entries_to_build       = 5
      required_reviewers         = []
      required_status_checks     = ["Format", "Validate"]
    }
  }

  # GitHub Actions の App ID
  github_actions_integration_id = 15368
}

resource "github_repository_ruleset" "default_branch" {
  for_each = local.rulesets

  repository  = github_repository.this[each.key].name
  name        = each.value.name
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
      allowed_merge_methods             = [each.value.merge_method]
      dismiss_stale_reviews_on_push     = each.value.dismiss_stale_reviews
      require_code_owner_review         = false
      require_last_push_approval        = false
      required_approving_review_count   = each.value.required_approving_reviews
      required_review_thread_resolution = false

      dynamic "required_reviewers" {
        for_each = each.value.required_reviewers
        content {
          file_patterns     = ["*"]
          minimum_approvals = required_reviewers.value.minimum_approvals
          reviewer {
            id   = github_team.this[required_reviewers.value.team].id
            type = "Team"
          }
        }
      }
    }

    dynamic "required_status_checks" {
      for_each = length(each.value.required_status_checks) > 0 ? [1] : []
      content {
        do_not_enforce_on_create             = false
        strict_required_status_checks_policy = false

        dynamic "required_check" {
          for_each = each.value.required_status_checks
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
      max_entries_to_build              = each.value.max_entries_to_build
      max_entries_to_merge              = 5
      merge_method                      = upper(each.value.merge_method)
      min_entries_to_merge              = 1
      min_entries_to_merge_wait_minutes = 5
    }
  }

  # 既存の bypass は User（kantacky）だが provider が actor_type = "User" に未対応のため、コンソール管理とする
  lifecycle {
    ignore_changes = [bypass_actors]
  }
}
