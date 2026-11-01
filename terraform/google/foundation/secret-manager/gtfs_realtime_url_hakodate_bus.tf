resource "google_secret_manager_secret" "gtfs_realtime_url_hakodate_bus" {
  secret_id = "gtfs_realtime_url_hakodate_bus"

  replication {
    auto {}
  }
}
