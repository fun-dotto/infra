locals {
  teams = {
    app = {
      name        = "App"
      maintainers = ["kantacky", "tanakarinna"]
      members     = ["suzukimifuyu", "takuyone68"]
    }
    designers = {
      name        = "Designers"
      maintainers = ["Uenosana"]
      members     = ["nao0507", "nao0701"]
    }
    masters = {
      name        = "Masters"
      maintainers = ["hikaru-0602", "kantacky", "masaya-osuga"]
      members     = ["tanakarinna", "Uenosana", "zakiPoteto"]
    }
    members = {
      name        = "Members"
      maintainers = ["hikaru-0602", "kantacky", "masaya-osuga", "tanakarinna", "Uenosana", "zakiPoteto"]
      members = [
        "Hosoda-abo",
        "hosu3",
        "KurenNagata",
        "mikaminasaki",
        "nao0507",
        "nao0701",
        "satorutkhs",
        "sayo-o518",
        "suzukimifuyu",
        "T-shinku0314",
        "takuyone68",
      ]
    }
    pm = {
      name        = "PM"
      maintainers = ["mikaminasaki"]
      members     = []
    }
    server = {
      name        = "Server"
      maintainers = ["hikaru-0602", "masaya-osuga", "zakiPoteto"]
      members     = ["Hosoda-abo", "KurenNagata", "sayo-o518", "T-shinku0314"]
    }
    web = {
      name        = "Web"
      maintainers = ["tanakarinna"]
      members     = ["T-shinku0314"]
    }
  }

  # リポジトリごとに直接付与した Team 権限（pull / triage / push / maintain / admin）
  # members の全リポジトリ read と masters の admin-web / client の admin は直接付与ではなく
  # Organization 側の設定（Organization role など）から継承しているため、ここには含めない
  team_repository_permissions = {
    app       = { app = "push", masters = "admin" }
    web       = { masters = "admin", web = "push" }
    admin-web = { app = "pull", server = "push", web = "pull" }
    client    = {}
    server    = { masters = "admin", server = "push" }
    infra     = { app = "push", masters = "admin", server = "push", web = "push" }
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
