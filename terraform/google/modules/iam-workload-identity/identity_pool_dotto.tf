resource "google_iam_workload_identity_pool" "dotto" {
  workload_identity_pool_id = "dotto"
  display_name              = "dotto"
}
