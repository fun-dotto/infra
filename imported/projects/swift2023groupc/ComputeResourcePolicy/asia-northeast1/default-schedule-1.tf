resource "google_compute_resource_policy" "default_schedule_1" {
  name    = "default-schedule-1"
  project = "swift2023groupc"
  region  = "asia-northeast1"

  snapshot_schedule_policy {
    retention_policy {
      max_retention_days    = 14
      on_source_disk_delete = "KEEP_AUTO_SNAPSHOTS"
    }

    schedule {
      daily_schedule {
        days_in_cycle = 1
        start_time    = "12:00"
      }
    }
  }
}
# terraform import google_compute_resource_policy.default_schedule_1 projects/swift2023groupc/regions/asia-northeast1/resourcePolicies/default-schedule-1
