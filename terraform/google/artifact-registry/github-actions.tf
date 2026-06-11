resource "google_artifact_registry_repository" "github_actions" {
  cleanup_policies {
    action = "DELETE"

    condition {
      older_than = "604800s"
      tag_state  = "ANY"
    }

    id = "Delete "
  }

  cleanup_policies {
    action = "KEEP"
    id     = "Keep Latest"

    most_recent_versions {
      keep_count = 1
    }
  }

  docker_config {
    immutable_tags = false
  }

  format = "DOCKER"

  location      = "asia-northeast1"
  mode          = "STANDARD_REPOSITORY"
  project       = "swift2023groupc"
  repository_id = "github-actions"
}
