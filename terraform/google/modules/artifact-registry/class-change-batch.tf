# TODO: terraform destroy --target google_artifact_registry_repository.class_change_batch

resource "google_artifact_registry_repository" "class_change_batch" {
  description = "class change batch job images"
  format      = "DOCKER"

  location      = "asia-northeast1"
  mode          = "STANDARD_REPOSITORY"
  project       = "swift2023groupc"
  repository_id = "class-change-batch"
}
