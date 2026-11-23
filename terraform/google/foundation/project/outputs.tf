output "firebase_apple_app_ids" {
  value = { for k, v in google_firebase_apple_app.this : k => v.app_id }
}

output "firebase_android_app_ids" {
  value = { for k, v in google_firebase_android_app.this : k => v.app_id }
}

output "firebase_web_app_ids" {
  value = { for k, v in google_firebase_web_app.this : k => v.app_id }
}
