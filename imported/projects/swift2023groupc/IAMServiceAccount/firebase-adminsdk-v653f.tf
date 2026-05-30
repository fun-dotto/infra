resource "google_service_account" "firebase_adminsdk_v653f" {
  account_id   = "firebase-adminsdk-v653f"
  description  = "Firebase Admin SDK Service Agent"
  display_name = "firebase-adminsdk"
  project      = "swift2023groupc"
}
# terraform import google_service_account.firebase_adminsdk_v653f projects/swift2023groupc/serviceAccounts/firebase-adminsdk-v653f@swift2023groupc.iam.gserviceaccount.com
