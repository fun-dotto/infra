# 手動 SQL で作成済みのロールを取り込む。GRANT と default privileges は import に対応していないため、
# apply で同じ内容が再設定される
import {
  to = postgresql_role.developer
  id = "dotto_developer"
}

import {
  for_each = local.environments

  to = postgresql_role.admin_environment[each.key]
  id = "dotto_admin_${each.key}"
}

import {
  for_each = local.environments

  to = postgresql_role.service[each.key]
  id = "dotto_service_${each.key}"
}

import {
  for_each = local.environments

  to = postgresql_role.migrate_readonly[each.key]
  id = "dotto_migrate_readonly_${each.key}"
}
