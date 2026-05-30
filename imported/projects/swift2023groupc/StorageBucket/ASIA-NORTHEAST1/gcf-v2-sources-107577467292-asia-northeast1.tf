resource "google_storage_bucket" "gcf_v2_sources_107577467292_asia_northeast1" {
  cors {
    method = ["GET"]
    origin = ["https://*.cloud.google.com", "https://*.corp.google.com", "https://*.corp.google.com:*", "https://*.cloud.google", "https://*.byoid.goog"]
  }

  force_destroy = false

  labels = {
    goog-managed-by = "cloudfunctions"
    managed-by-cnrm = "true"
  }

  lifecycle_rule {
    action {
      type = "Delete"
    }

    condition {
      num_newer_versions = 3
      with_state         = "ARCHIVED"
    }
  }

  location                 = "ASIA-NORTHEAST1"
  name                     = "gcf-v2-sources-107577467292-asia-northeast1"
  project                  = "swift2023groupc"
  public_access_prevention = "inherited"

  soft_delete_policy {
    retention_duration_seconds = 604800
  }

  storage_class               = "STANDARD"
  uniform_bucket_level_access = true

  versioning {
    enabled = true
  }
}
# terraform import google_storage_bucket.gcf_v2_sources_107577467292_asia_northeast1 gcf-v2-sources-107577467292-asia-northeast1
