terraform {
  backend "gcs" {
    bucket = "swift2023groupc-tfstate"
    prefix = "server/build-irregular-notification-job-dev"
  }
}
