terraform {
  backend "gcs" {
    bucket = "swift2023groupc-tfstate"
    prefix = "server/academic-service-prd"
  }
}
