resource "google_secret_manager_secret" "gtfs_schedule" {
  secret_id = "gtfs_schedule"

  replication {
    auto {}
  }
}

resource "google_secret_manager_secret_iam_member" "gtfs_schedule" {
  secret_id = google_secret_manager_secret.gtfs_schedule.secret_id
  role      = "roles/secretmanager.secretAccessor"
  member    = local.app_secret_accessor_member
}
