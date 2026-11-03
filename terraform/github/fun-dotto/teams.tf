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
