terraform {
  backend "gcs" {
    bucket = "swift2023groupc-tfstate"
    prefix = "server/fetch-syllabuses-job-prd"
  }
}
