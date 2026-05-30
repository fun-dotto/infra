resource "google_storage_bucket" "asia_artifacts_swift2023groupc_appspot_com" {
  force_destroy = false

  labels = {
    managed-by-cnrm = "true"
  }

  location                 = "ASIA"
  name                     = "asia.artifacts.swift2023groupc.appspot.com"
  project                  = "swift2023groupc"
  public_access_prevention = "inherited"

  soft_delete_policy {
    retention_duration_seconds = 604800
  }

  storage_class = "STANDARD"
}
# terraform import google_storage_bucket.asia_artifacts_swift2023groupc_appspot_com asia.artifacts.swift2023groupc.appspot.com
