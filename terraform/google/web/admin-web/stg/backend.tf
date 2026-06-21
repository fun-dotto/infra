terraform {
  backend "gcs" {
    bucket = "swift2023groupc-tfstate"
    prefix = "web/admin-web-stg"
  }
}
