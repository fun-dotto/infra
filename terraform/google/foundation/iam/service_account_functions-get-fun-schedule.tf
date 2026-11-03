resource "google_service_account" "functions_get_fun_schedule" {
  account_id   = "functions-get-fun-schedule"
  display_name = "Functions Get FUN Schedule"
}

import {
  to = google_service_account.functions_get_fun_schedule
  id = "projects/${var.google_cloud_project_id}/serviceAccounts/functions-get-fun-schedule@${var.google_cloud_project_id}.iam.gserviceaccount.com"
}
