resource "google_service_account" "functions_get_fun_schedule" {
  account_id   = "functions-get-fun-schedule"
  display_name = "Functions Get FUN Schedule"
  project      = "swift2023groupc"
}
# terraform import google_service_account.functions_get_fun_schedule projects/swift2023groupc/serviceAccounts/functions-get-fun-schedule@swift2023groupc.iam.gserviceaccount.com
