terraform {
  backend "gcs" {
    bucket = "swift2023groupc-tfstate"
    prefix = "iam-service-account"
  }
}
