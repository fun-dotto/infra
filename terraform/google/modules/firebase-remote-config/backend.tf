terraform {
  backend "gcs" {
    bucket = "swift2023groupc-tfstate"
    prefix = "firebase-remote-config"
  }
}
# Direct WIF の検証用（マージ前に削除する）
