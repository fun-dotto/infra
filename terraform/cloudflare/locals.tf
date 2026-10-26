locals {
  # access_in_prd: prd で Cloudflare Access をかけるか（prd の web / app-api はかけず App Check で保護する）
  service_definitions = {
    web       = { subdomain = "", state_prefix = "web/web", access_in_prd = false }
    admin_web = { subdomain = "admin", state_prefix = "web/admin-web", access_in_prd = true }
    app_api   = { subdomain = "api", state_prefix = "server/app-api", access_in_prd = false }
    admin_api = { subdomain = "admin-api", state_prefix = "server/admin-api", access_in_prd = true }
  }

  # key: "<環境>/<サービス>"
  services = merge([
    for env in var.environments : {
      for name, def in local.service_definitions : "${env}/${name}" => {
        environment = env
        name        = name
        # {サービス}-{環境}.fun-dotto.com。prd は環境名を付けず、web はサービス名を省略する
        hostname = join(".", compact([
          def.subdomain == "" ? (env == "prd" ? "" : env) : (env == "prd" ? def.subdomain : "${def.subdomain}-${env}"),
          var.cloudflare_zone_name,
        ]))
        # web / admin-web の prd は環境名なしの state prefix
        state_prefix = startswith(def.state_prefix, "web/") && env == "prd" ? def.state_prefix : "${def.state_prefix}-${env}"
        access       = env != "prd" || def.access_in_prd
      }
    }
  ]...)

  access_services = { for k, v in local.services : k => v if v.access }
}
