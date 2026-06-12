terraform {
  backend "gcs" {
    bucket = "swift2023groupc-tfstate"
    prefix = "cloud-run-job"
  }
}
