terraform {
  backend "gcs" {
    bucket = "swift2023groupc-tfstate"
    prefix = "server/admin-api-stg"
  }
}
