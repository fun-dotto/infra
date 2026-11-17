# 各環境の DB 内の権限。DB への CONNECT はプロバイダの不具合 (cyrilgdn/terraform-provider-postgresql#681) で
# 反映されないことがあるため、手動 SQL で管理する (docs/atlas-migration.md)

# public スキーマ: 主キー追加時のインデックス作成などに CREATE が必要
resource "postgresql_grant" "admin_public_schema" {
  for_each = local.environments

  database    = each.value.database
  role        = postgresql_role.admin_environment[each.key].name
  schema      = "public"
  object_type = "schema"
  privileges  = ["CREATE", "USAGE"]
}

# 既存テーブル
resource "postgresql_grant" "service_tables" {
  for_each = local.environments

  database    = each.value.database
  role        = postgresql_role.service[each.key].name
  schema      = "public"
  object_type = "table"
  privileges  = local.service_table_privileges
}

resource "postgresql_grant" "developer_tables" {
  for_each = local.environments

  database    = each.value.database
  role        = postgresql_role.developer.name
  schema      = "public"
  object_type = "table"
  privileges  = each.value.developer_table_privileges
}

# dotto_admin_<env> がこれから作るテーブル (スキーマを問わない)
resource "postgresql_default_privileges" "service_tables" {
  for_each = local.environments

  database    = each.value.database
  owner       = postgresql_role.admin_environment[each.key].name
  role        = postgresql_role.service[each.key].name
  object_type = "table"
  privileges  = local.service_table_privileges
}

resource "postgresql_default_privileges" "developer_tables" {
  for_each = local.environments

  database    = each.value.database
  owner       = postgresql_role.admin_environment[each.key].name
  role        = postgresql_role.developer.name
  object_type = "table"
  privileges  = each.value.developer_table_privileges
}

# Atlas のリビジョンテーブル用のスキーマ。既にあれば owner だけを設定する。
# 先に作っておくことで、初回のマイグレーション前から dry-run 用ロールに権限を付与できる
resource "postgresql_schema" "atlas_schema_revisions" {
  for_each = local.environments

  database = each.value.database
  name     = "atlas_schema_revisions"
  owner    = postgresql_role.admin_environment[each.key].name

  lifecycle {
    prevent_destroy = true
  }
}

resource "postgresql_grant" "migrate_readonly_revisions_schema" {
  for_each = local.environments

  database    = each.value.database
  role        = postgresql_role.migrate_readonly[each.key].name
  schema      = postgresql_schema.atlas_schema_revisions[each.key].name
  object_type = "schema"
  privileges  = ["USAGE"]
}

resource "postgresql_grant" "migrate_readonly_revisions_tables" {
  for_each = local.environments

  database    = each.value.database
  role        = postgresql_role.migrate_readonly[each.key].name
  schema      = postgresql_schema.atlas_schema_revisions[each.key].name
  object_type = "table"
  privileges  = ["SELECT"]
}

resource "postgresql_default_privileges" "migrate_readonly_revisions_tables" {
  for_each = local.environments

  database    = each.value.database
  owner       = postgresql_role.admin_environment[each.key].name
  role        = postgresql_role.migrate_readonly[each.key].name
  schema      = postgresql_schema.atlas_schema_revisions[each.key].name
  object_type = "table"
  privileges  = ["SELECT"]
}
