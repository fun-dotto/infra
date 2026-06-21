terraform {
  backend "gcs" {
    bucket = "swift2023groupc-tfstate"
    prefix = "server/notify-user-job-dev"
  }
}
