resource "google_compute_network" "dotto" {
  name                    = "dotto"
  auto_create_subnetworks = false
}

# Cloud Run の Direct VPC egress 用サブネット
resource "google_compute_subnetwork" "cloud_run" {
  name                     = "cloud-run-${var.google_cloud_region}"
  network                  = google_compute_network.dotto.id
  region                   = var.google_cloud_region
  ip_cidr_range            = "10.0.0.0/20"
  private_ip_google_access = true
}
