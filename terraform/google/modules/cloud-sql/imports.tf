import {
  for_each = local.database_service_accounts

  id = "swift2023groupc/dotto/${each.value}@swift2023groupc.iam"
  to = google_sql_user.service_account[each.value]
}

import {
  for_each = local.database_admins

  id = "swift2023groupc/dotto/${each.value}"
  to = google_sql_user.admin[each.value]
}

import {
  for_each = local.database_developers

  id = "swift2023groupc/dotto/${each.value}"
  to = google_sql_user.developer[each.value]
}
