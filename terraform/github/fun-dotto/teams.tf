locals {
  teams = {
    app = {
      name        = "App"
      maintainers = ["kantacky"]
      members     = ["Hosoda-abo", "suzukimifuyu", "takuyone68", "tanakarinna"]
    }
    designers = {
      name        = "Designers"
      maintainers = []
      members     = ["nao0507", "nao0701", "nearorenge", "Uenosana"]
    }
    masters = {
      name        = "Masters"
      maintainers = ["hikaru-0602", "kantacky", "masaya-osuga"]
      members     = ["Hosoda-abo"]
    }
    members = {
      name        = "Members"
      maintainers = ["hikaru-0602", "kantacky", "masaya-osuga"]
      members = [
        "aya-kita",
        "Hosoda-abo",
        "hosu3",
        "KAZZ00777",
        "KurenNagata",
        "mikaminasaki",
        "nao0507",
        "nao0701",
        "nearorenge",
        "satorutkhs",
        "sayo-o518",
        "suzukimifuyu",
        "T-shinku0314",
        "takuyone68",
        "tanakarinna",
        "Uenosana",
        "zakiPoteto",
      ]
    }
    pm = {
      name        = "PM"
      maintainers = []
      members     = ["mikaminasaki"]
    }
    server = {
      name        = "Server"
      maintainers = ["hikaru-0602", "masaya-osuga"]
      members     = ["Hosoda-abo", "KAZZ00777", "KurenNagata", "sayo-o518", "zakiPoteto"]
    }
    web = {
      name        = "Web"
      maintainers = []
      members     = ["Hosoda-abo", "T-shinku0314"]
    }
  }

  # リポジトリごとの Team 権限（pull / triage / push / maintain / admin）
  team_repository_permissions = {
    app       = { app = "push", masters = "admin", members = "pull" }
    web       = { masters = "admin", members = "pull", web = "push" }
    admin-web = { app = "pull", masters = "admin", members = "pull", server = "push", web = "pull" }
    client    = { masters = "admin", members = "pull" }
    server    = { masters = "admin", members = "pull", server = "push" }
    infra     = { app = "push", masters = "admin", members = "pull", server = "push", web = "push" }
  }

  team_repositories = merge([
    for repository, teams in local.team_repository_permissions : {
      for team, permission in teams : "${team}:${repository}" => {
        team       = team
        repository = repository
        permission = permission
      }
    }
  ]...)
}

resource "github_team" "this" {
  for_each = local.teams

  name        = each.value.name
  description = ""
  privacy     = "closed"
}

# Team のメンバーを authoritative に管理する。Org メンバーになってから Team に追加する
resource "github_team_members" "this" {
  for_each = local.teams

  team_id = github_team.this[each.key].id

  dynamic "members" {
    for_each = toset(each.value.maintainers)
    content {
      username = members.value
      role     = "maintainer"
    }
  }

  dynamic "members" {
    for_each = toset(each.value.members)
    content {
      username = members.value
      role     = "member"
    }
  }

  depends_on = [github_membership.this]
}

resource "github_team_repository" "this" {
  for_each = local.team_repositories

  team_id    = github_team.this[each.value.team].id
  repository = github_repository.this[each.value.repository].name
  permission = each.value.permission
}
