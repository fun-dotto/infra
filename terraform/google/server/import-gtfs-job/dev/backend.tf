terraform {
  backend "gcs" {
    bucket = "swift2023groupc-tfstate"
    prefix = "server/import-gtfs-job-dev"
  }
}
