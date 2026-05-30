resource "google_service_account" "github_actions" {
  account_id   = "github-actions"
  display_name = "GitHub Actions"
  project      = "swift2023groupc"
}
# terraform import google_service_account.github_actions projects/swift2023groupc/serviceAccounts/github-actions@swift2023groupc.iam.gserviceaccount.com
