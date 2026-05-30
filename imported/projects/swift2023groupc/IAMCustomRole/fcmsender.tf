resource "google_project_iam_custom_role" "fcmsender" {
  description = "Send FCM messages via the HTTP v1 API"
  permissions = ["cloudmessaging.messages.create"]
  project     = "swift2023groupc"
  role_id     = "fcmSender"
  stage       = "GA"
  title       = "FCM Sender"
}
# terraform import google_project_iam_custom_role.fcmsender swift2023groupc##fcmSender
