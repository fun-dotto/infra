locals {
  admins = [
    "hikaru-0602",
    "kantacky",
    "masaya-osuga",
    "tigertora7571",
  ]

  members = [
    "39shin52",
    "aya-kita",
    "ayanentity",
    "Hosoda-abo",
    "hosu3",
    "KAZZ00777",
    "KurenNagata",
    "masayoshisuzuki441",
    "mikaminasaki",
    "nao0507",
    "nao0701",
    "nearorenge",
    "ryka-1104",
    "satorutkhs",
    "sayo-o518",
    "suzukimifuyu",
    "T-shinku0314",
    "takuyone68",
    "tanakarinna",
    "Uenosana",
    "zakiPoteto",
  ]

  memberships = merge(
    { for login in local.admins : login => "admin" },
    { for login in local.members : login => "member" },
  )
}

resource "github_membership" "this" {
  for_each = local.memberships

  username = each.key
  role     = each.value

  # destroy は Org からの削除になるため、メンバーを外すときは prevent_destroy を一時的に外す
  lifecycle {
    prevent_destroy = true
  }
}
