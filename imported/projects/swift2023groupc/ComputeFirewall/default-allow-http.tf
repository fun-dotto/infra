resource "google_compute_firewall" "default_allow_http" {
  allow {
    ports    = ["80"]
    protocol = "tcp"
  }

  direction     = "INGRESS"
  name          = "default-allow-http"
  network       = "https://www.googleapis.com/compute/v1/projects/swift2023groupc/global/networks/default"
  priority      = 1000
  project       = "swift2023groupc"
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["http-server"]
}
# terraform import google_compute_firewall.default_allow_http projects/swift2023groupc/global/firewalls/default-allow-http
