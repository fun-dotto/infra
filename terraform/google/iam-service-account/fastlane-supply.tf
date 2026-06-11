resource "google_service_account" "fastlane_supply" {
  account_id   = "fastlane-supply"
  description  = "Account used to give fastlane supply access to Google Play Console."
  display_name = "fastlane-supply"
}
