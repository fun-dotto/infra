terraform {
  backend "gcs" {
    bucket = "swift2023groupc-tfstate"
    prefix = "server/app-bff-api-prd"
  }
}
