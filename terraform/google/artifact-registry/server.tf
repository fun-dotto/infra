resource "google_artifact_registry_repository" "server" {
  cleanup_policies {
    action = "DELETE"

    condition {
      older_than = "604800s"
      tag_state  = "UNTAGGED"
    }

    id = "delete-untagged-after-7d"
  }

  cleanup_policies {
    action = "DELETE"

    condition {
      tag_state = "TAGGED"
    }

    id = "delete-old-tagged"
  }

  cleanup_policies {
    action = "KEEP"
    id     = "keep-recent-tagged"

    most_recent_versions {
      keep_count = 50
    }
  }

  description = "Modular monolith server image (multi-binary)"
  format      = "DOCKER"

  location      = "asia-northeast1"
  mode          = "STANDARD_REPOSITORY"
  project       = "swift2023groupc"
  repository_id = "server"
}
