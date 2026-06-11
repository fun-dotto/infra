resource "google_artifact_registry_repository" "class_change_batch" {
  description = "class change batch job images"
  format      = "DOCKER"

  labels = {
    goog-terraform-provisioned = "true"
    managed-by-cnrm            = "true"
  }

  location      = "asia-northeast1"
  mode          = "STANDARD_REPOSITORY"
  project       = "swift2023groupc"
  repository_id = "class-change-batch"
}
# terraform import google_artifact_registry_repository.class_change_batch projects/swift2023groupc/locations/asia-northeast1/repositories/class-change-batch
