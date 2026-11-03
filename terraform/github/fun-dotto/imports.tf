locals {
  import_team_ids = {
    app       = 13010427
    designers = 13010409
    masters   = 14928826
    members   = 15139328
    pm        = 18028734
    server    = 14928885
    web       = 17258603
  }
}

import {
  to = github_organization_settings.this
  id = "136790315"
}

import {
  for_each = local.memberships
  to       = github_membership.this[each.key]
  id       = "fun-dotto:${each.key}"
}

import {
  for_each = local.import_team_ids
  to       = github_team.this[each.key]
  id       = each.value
}

import {
  for_each = local.import_team_ids
  to       = github_team_members.this[each.key]
  id       = each.value
}
