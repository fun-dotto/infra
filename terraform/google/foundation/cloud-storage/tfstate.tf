resource "google_storage_bucket" "tfstate" {
  name     = "swift2023groupc-tfstate"
  location = var.google_cloud_region
}
