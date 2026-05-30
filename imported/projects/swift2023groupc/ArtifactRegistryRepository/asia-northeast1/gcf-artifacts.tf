resource "google_artifact_registry_repository" "gcf_artifacts" {
  cleanup_policies {
    action = "DELETE"

    condition {
      older_than = "86400s"
      tag_state  = "ANY"
    }

    id = "firebase-functions-cleanup"
  }

  description = "This repository is created and used by Cloud Functions for storing function docker images."
  format      = "DOCKER"

  labels = {
    goog-managed-by = "cloudfunctions"
    managed-by-cnrm = "true"
  }

  location      = "asia-northeast1"
  mode          = "STANDARD_REPOSITORY"
  project       = "swift2023groupc"
  repository_id = "gcf-artifacts"
}
# terraform import google_artifact_registry_repository.gcf_artifacts projects/swift2023groupc/locations/asia-northeast1/repositories/gcf-artifacts
