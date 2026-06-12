terraform {
  backend "gcs" {
    bucket = "swift2023groupc-tfstate"
    prefix = "firebase-remote-config"
  }
}
