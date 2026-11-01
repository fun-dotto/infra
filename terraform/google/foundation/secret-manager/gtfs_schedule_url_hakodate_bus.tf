resource "google_secret_manager_secret" "gtfs_schedule_url_hakodate_bus" {
  secret_id = "gtfs_schedule_url_hakodate_bus"

  replication {
    auto {}
  }
}
