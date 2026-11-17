locals {
  # 環境 => DB 名と、dotto_developer に付与するテーブル権限 (prd は SELECT のみ)
  environments = {
    dev = {
      database                   = "dotto_dev"
      developer_table_privileges = ["DELETE", "INSERT", "SELECT", "UPDATE"]
    }
    stg = {
      database                   = "dotto_stg"
      developer_table_privileges = ["DELETE", "INSERT", "SELECT", "UPDATE"]
    }
    prd = {
      database                   = "dotto"
      developer_table_privileges = ["SELECT"]
    }
  }

  service_table_privileges = ["DELETE", "INSERT", "SELECT", "UPDATE"]
}
