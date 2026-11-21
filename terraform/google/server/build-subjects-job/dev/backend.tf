terraform {
  backend "gcs" {
    bucket = "swift2023groupc-tfstate"
    prefix = "server/build-subjects-job-dev"
  }
}
