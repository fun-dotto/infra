terraform {
  backend "gcs" {
    bucket = "swift2023groupc-tfstate"
    prefix = "secret-manager"
  }
}
