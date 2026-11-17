# ロールはインスタンス共通。構成は docs/postgresql_roles.md を参照。
# 誤って削除すると所有オブジェクトが REASSIGN OWNED されるため、prevent_destroy で守る

# 開発者の調査・検証用
resource "postgresql_role" "developer" {
  name = "dotto_developer"

  lifecycle {
    prevent_destroy = true
  }
}

# 各環境のマイグレーション実行・オブジェクトの owner。自環境の dotto_service_<env> のメンバー
resource "postgresql_role" "admin_environment" {
  for_each = local.environments

  name  = "dotto_admin_${each.key}"
  roles = [postgresql_role.service[each.key].name]

  lifecycle {
    prevent_destroy = true
  }
}

# 各環境のアプリ実行時
resource "postgresql_role" "service" {
  for_each = local.environments

  name = "dotto_service_${each.key}"

  lifecycle {
    prevent_destroy = true
  }
}

# 各環境のマイグレーションの dry-run 用 (読み取り専用)
resource "postgresql_role" "migrate_readonly" {
  for_each = local.environments

  name = "dotto_migrate_readonly_${each.key}"

  lifecycle {
    prevent_destroy = true
  }
}
