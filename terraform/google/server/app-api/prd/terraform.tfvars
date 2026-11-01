service_account_id                  = "app-api"
service_account_display_name        = "App API"
db_name                             = "dotto"
service_name                        = "app-api"
max_instance_count                  = 3
min_instance_count                  = 0 # TODO: 本番運用開始時に 1 に戻す
id_token_allowed_service_account_id = "web-prd"
db_max_open_conns                   = 4
