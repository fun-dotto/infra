resource "google_artifact_registry_repository" "batch_jobs" {
  description = "batch jobs (Go) job images"
  format      = "DOCKER"

  labels = {
    goog-terraform-provisioned = "true"
    managed-by-cnrm            = "true"
  }

  location      = "asia-northeast1"
  mode          = "STANDARD_REPOSITORY"
  project       = "swift2023groupc"
  repository_id = "batch-jobs"
}
# terraform import google_artifact_registry_repository.batch_jobs projects/swift2023groupc/locations/asia-northeast1/repositories/batch-jobs
