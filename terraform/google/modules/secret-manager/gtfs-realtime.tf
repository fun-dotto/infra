resource "google_secret_manager_secret" "gtfs_realtime" {
  secret_id = "gtfs_realtime"

  replication {
    auto {}
  }
}

resource "google_secret_manager_secret_iam_member" "gtfs_realtime" {
  secret_id = google_secret_manager_secret.gtfs_realtime.secret_id
  role      = "roles/secretmanager.secretAccessor"
  member    = local.app_secret_accessor_member
}
