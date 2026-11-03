# Organization 全体の GitHub Actions Variable
locals {
  organization_variables = {
    DOTTO_APPLE_CERTIFICATES_USER_APP_CLIENT_ID = "Iv23liBHAfAKmd9zQtsZ"
    DOTTO_GITHUB_MANAGER_APP_CLIENT_ID          = "Iv23liu5zZnSrzUDdtld"
    DOTTO_PROTO_UPDATER_APP_CLIENT_ID           = "Iv23liV8BUa9y1WfLCg1"
  }
}

resource "github_actions_organization_variable" "this" {
  for_each = local.organization_variables

  variable_name = each.key
  value         = each.value
  visibility    = "all"
}
