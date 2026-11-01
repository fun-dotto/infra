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

# Direct VPC egress で全トラフィックを VPC に流す Cloud Run (cloudflared) がインターネットに出るための NAT
resource "google_compute_router" "dotto" {
  name    = "dotto-${var.google_cloud_region}"
  network = google_compute_network.dotto.id
  region  = var.google_cloud_region
}

resource "google_compute_router_nat" "dotto" {
  name                               = "dotto-${var.google_cloud_region}"
  router                             = google_compute_router.dotto.name
  region                             = var.google_cloud_region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
}
