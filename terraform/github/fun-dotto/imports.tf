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

import {
  for_each = local.team_repositories
  to       = github_team_repository.this[each.key]
  id       = "${local.import_team_ids[each.value.team]}:${each.value.repository}"
}

# 既存の Environment・Variable を取り込む (Secret は値を上書きするため import 不要)
import {
  for_each = local.repository_environments
  to       = github_repository_environment.this[each.key]
  id       = each.key
}

import {
  for_each = local.repository_variables
  to       = github_actions_variable.this[each.key]
  id       = each.key
}
