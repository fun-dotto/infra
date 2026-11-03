resource "github_repository" "this" {
  for_each = local.repositories

  name         = each.key
  description  = each.value.description
  homepage_url = each.value.homepage_url
  topics       = each.value.topics
  visibility   = "public"

  has_issues      = true
  has_projects    = true
  has_wiki        = each.value.has_wiki
  has_discussions = false

  allow_merge_commit          = each.value.allow_merge_commit
  allow_squash_merge          = true
  allow_rebase_merge          = true
  allow_auto_merge            = each.value.allow_auto_merge
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
