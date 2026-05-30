resource "google_storage_bucket" "swift2023groupc_tfstate" {
  force_destroy = false

  labels = {
    managed-by-cnrm = "true"
  }

  location                 = "ASIA-NORTHEAST1"
  name                     = "swift2023groupc-tfstate"
  project                  = "swift2023groupc"
  public_access_prevention = "enforced"

  soft_delete_policy {
    retention_duration_seconds = 604800
  }

  storage_class               = "STANDARD"
  uniform_bucket_level_access = true

  versioning {
    enabled = true
  }
}
# terraform import google_storage_bucket.swift2023groupc_tfstate swift2023groupc-tfstate
