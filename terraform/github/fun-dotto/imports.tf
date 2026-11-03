import {
  to = github_organization_settings.this
  id = "136790315"
}

import {
  for_each = local.repositories
  to       = github_repository.this[each.key]
  id       = each.key
}

import {
  for_each = {
    app       = 6917853
    web       = 14617929
    admin-web = 12979229
    client    = 25890397
    server    = 16189525
    infra     = 17262173
  }
  to = github_repository_ruleset.default_branch[each.key]
  id = "${each.key}:${each.value}"
}
