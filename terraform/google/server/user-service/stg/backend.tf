terraform {
  backend "gcs" {
    bucket = "swift2023groupc-tfstate"
    prefix = "server/user-service-stg"
  }
}
