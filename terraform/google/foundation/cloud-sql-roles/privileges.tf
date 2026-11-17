# DB への CONNECT はプロバイダの不具合 (cyrilgdn/terraform-provider-postgresql#681) のため手動 SQL で管理する

# 主キー追加時のインデックス作成などに必要
resource "postgresql_grant" "admin_public_schema" {
  for_each = local.environments

  database    = each.value.database
  role        = postgresql_role.admin_environment[each.key].name
  schema      = "public"
  object_type = "schema"
  privileges  = ["CREATE", "USAGE"]
}

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

  # 同じテーブルへの GRANT を並列に実行すると tuple concurrently updated で失敗するため直列にする
  # (cyrilgdn/terraform-provider-postgresql#178)
  depends_on = [postgresql_grant.service_tables]
}

resource "postgresql_default_privileges" "service_tables" {
  for_each = local.environments

  database    = each.value.database
  owner       = postgresql_role.admin_environment[each.key].name
  role        = postgresql_role.service[each.key].name
  object_type = "table"
  privileges  = local.service_table_privileges
}

resource "postgresql_default_privileges" "service_sequences" {
  for_each = local.environments

  database    = each.value.database
  owner       = postgresql_role.admin_environment[each.key].name
  role        = postgresql_role.service[each.key].name
  object_type = "sequence"
  privileges  = ["SELECT", "USAGE"]
}

resource "postgresql_default_privileges" "developer_tables" {
  for_each = local.environments

  database    = each.value.database
  owner       = postgresql_role.admin_environment[each.key].name
  role        = postgresql_role.developer.name
  object_type = "table"
  privileges  = each.value.developer_table_privileges
}

# 初回のマイグレーション前から dry-run 用ロールに権限を付与するため先に作る (既にあれば owner だけを設定する)
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
