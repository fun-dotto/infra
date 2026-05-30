resource "google_storage_bucket" "swift2023groupc_appspot_com" {
  cors {
    max_age_seconds = 3600
    method          = ["GET"]
    origin          = ["*"]
  }

  force_destroy = false

  labels = {
    managed-by-cnrm = "true"
  }

  location                 = "ASIA-NORTHEAST1"
  name                     = "swift2023groupc.appspot.com"
  project                  = "swift2023groupc"
  public_access_prevention = "inherited"

  soft_delete_policy {
    retention_duration_seconds = 604800
  }

  storage_class = "STANDARD"
}
# terraform import google_storage_bucket.swift2023groupc_appspot_com swift2023groupc.appspot.com
