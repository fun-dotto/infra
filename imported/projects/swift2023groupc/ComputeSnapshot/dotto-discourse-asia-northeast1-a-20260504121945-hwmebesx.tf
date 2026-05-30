resource "google_compute_snapshot" "dotto_discourse_asia_northeast1_a_20260504121945_hwmebesx" {
  labels = {
    managed-by-cnrm = "true"
  }

  name              = "dotto-discourse-asia-northeast1-a-20260504121945-hwmebesx"
  project           = "swift2023groupc"
  source_disk       = "https://www.googleapis.com/compute/v1/projects/swift2023groupc/zones/asia-northeast1-a/disks/dotto-discourse"
  storage_locations = ["asia"]
}
# terraform import google_compute_snapshot.dotto_discourse_asia_northeast1_a_20260504121945_hwmebesx projects/swift2023groupc/global/snapshots/dotto-discourse-asia-northeast1-a-20260504121945-hwmebesx
