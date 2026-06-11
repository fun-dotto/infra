resource "google_artifact_registry_repository" "batch_jobs" {
  description = "batch jobs (Go) job images"
  format      = "DOCKER"

  location      = "asia-northeast1"
  mode          = "STANDARD_REPOSITORY"
  project       = "swift2023groupc"
  repository_id = "batch-jobs"
}
