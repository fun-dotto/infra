resource "github_team_repository" "this" {
  for_each = var.team_permissions

  team_id    = each.value.team_id
  repository = github_repository.this.name
  permission = each.value.permission
}
