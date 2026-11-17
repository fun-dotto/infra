locals {
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
