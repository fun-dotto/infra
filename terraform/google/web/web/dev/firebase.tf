# Firebase の Web アプリ設定 (apiKey, authDomain など) を取得する
# web_app_id は Firebase コンソールの「プロジェクトの設定 > マイアプリ」のアプリ ID (1:xxxx:web:xxxx)
data "google_firebase_web_app_config" "default" {
  provider   = google-beta
  web_app_id = "TODO: Firebase Web アプリ ID"
}
