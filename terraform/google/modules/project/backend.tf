terraform {
  backend "gcs" {
    bucket = "swift2023groupc-tfstate"
    prefix = "project"
  }
}
# Direct WIF の検証用（マージ前に削除する）
