terraform {
  backend "gcs" {
    bucket = "swift2023groupc-tfstate"
    prefix = "server/funch-service-prd"
  }
}
