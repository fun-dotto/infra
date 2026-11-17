# 削除すると所有オブジェクトが REASSIGN OWNED されるため prevent_destroy で守る

resource "postgresql_role" "developer" {
  name = "dotto_developer"

  lifecycle {
    prevent_destroy = true
  }
}

resource "postgresql_role" "admin_environment" {
  for_each = local.environments

  name  = "dotto_admin_${each.key}"
  roles = [postgresql_role.service[each.key].name]

  lifecycle {
    prevent_destroy = true
  }
}

resource "postgresql_role" "service" {
  for_each = local.environments

  name = "dotto_service_${each.key}"

  lifecycle {
    prevent_destroy = true
  }
}

resource "postgresql_role" "migrate_readonly" {
  for_each = local.environments

  name = "dotto_migrate_readonly_${each.key}"

  lifecycle {
    prevent_destroy = true
  }
}
