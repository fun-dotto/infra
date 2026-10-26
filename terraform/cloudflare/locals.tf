locals {
  # access_in_prd: prd で Cloudflare Access をかけるか（prd の web / app-api はかけず App Check で保護する）
  service_definitions = {
    web       = { subdomain = "", cloud_run_service = "web", access_in_prd = false }
    admin_web = { subdomain = "admin", cloud_run_service = "admin-web", access_in_prd = true }
    app_api   = { subdomain = "api", cloud_run_service = "app-api", access_in_prd = false }
    admin_api = { subdomain = "admin-api", cloud_run_service = "admin-api", access_in_prd = true }
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
        # Cloud Run サービスより先に apply できるよう、remote state ではなく run.app のホスト名を組み立てる
        origin_host = "${def.cloud_run_service}${env == "prd" ? "" : "-${env}"}-${data.google_project.default.number}.${var.google_cloud_region}.run.app"
        access      = env != "prd" || def.access_in_prd
      }
    }
  ]...)

  access_services = { for k, v in local.services : k => v if v.access }
}
