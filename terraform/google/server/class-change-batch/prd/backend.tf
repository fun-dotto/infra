terraform {
  backend "gcs" {
    bucket = "swift2023groupc-tfstate"
    prefix = "server/class-change-batch-prd"
  }
}
