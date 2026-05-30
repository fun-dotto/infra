resource "google_compute_snapshot" "dotto_discourse_asia_northeast1_a_20260428121945_cc44zpgo" {
  labels = {
    managed-by-cnrm = "true"
  }

  name              = "dotto-discourse-asia-northeast1-a-20260428121945-cc44zpgo"
  project           = "swift2023groupc"
  source_disk       = "https://www.googleapis.com/compute/v1/projects/swift2023groupc/zones/asia-northeast1-a/disks/dotto-discourse"
  storage_locations = ["asia"]
}
# terraform import google_compute_snapshot.dotto_discourse_asia_northeast1_a_20260428121945_cc44zpgo projects/swift2023groupc/global/snapshots/dotto-discourse-asia-northeast1-a-20260428121945-cc44zpgo
