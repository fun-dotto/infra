resource "google_service_account" "fastlane_supply" {
  account_id   = "fastlane-supply"
  description  = "Account used to give fastlane supply access to Google Play Console."
  display_name = "fastlane-supply"
  project      = "swift2023groupc"
}
# terraform import google_service_account.fastlane_supply projects/swift2023groupc/serviceAccounts/fastlane-supply@swift2023groupc.iam.gserviceaccount.com
