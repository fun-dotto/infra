resource "google_service_account" "functions_get_fun_schedule" {
  account_id   = "functions-get-fun-schedule"
  display_name = "Functions Get FUN Schedule"
}

resource "google_service_account_iam_member" "functions_get_fun_schedule_admin" {
  service_account_id = google_service_account.functions_get_fun_schedule.name
  role               = "roles/iam.serviceAccountAdmin"
  member             = "user:TIGERtora7571@gmail.com"
}
