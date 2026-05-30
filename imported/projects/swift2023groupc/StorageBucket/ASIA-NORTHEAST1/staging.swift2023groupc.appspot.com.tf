resource "google_storage_bucket" "staging_swift2023groupc_appspot_com" {
  force_destroy = false

  labels = {
    managed-by-cnrm = "true"
  }

  lifecycle_rule {
    action {
      type = "Delete"
    }

    condition {
      age        = 15
      with_state = "ANY"
    }
  }

  location                 = "ASIA-NORTHEAST1"
  name                     = "staging.swift2023groupc.appspot.com"
  project                  = "swift2023groupc"
  public_access_prevention = "inherited"

  soft_delete_policy {
    retention_duration_seconds = 604800
  }

  storage_class = "STANDARD"
}
# terraform import google_storage_bucket.staging_swift2023groupc_appspot_com staging.swift2023groupc.appspot.com
