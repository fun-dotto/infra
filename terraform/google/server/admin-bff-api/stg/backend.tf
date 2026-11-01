terraform {
  backend "gcs" {
    bucket = "swift2023groupc-tfstate"
    prefix = "server/admin-bff-api-stg"
  }
}
