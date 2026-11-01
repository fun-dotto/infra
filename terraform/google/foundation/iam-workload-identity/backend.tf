terraform {
  backend "gcs" {
    bucket = "swift2023groupc-tfstate"
    prefix = "iam-workload-identity"
  }
}
