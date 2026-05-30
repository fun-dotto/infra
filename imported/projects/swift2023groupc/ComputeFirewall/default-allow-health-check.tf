resource "google_compute_firewall" "default_allow_health_check" {
  allow {
    protocol = "tcp"
  }

  direction     = "INGRESS"
  name          = "default-allow-health-check"
  network       = "https://www.googleapis.com/compute/v1/projects/swift2023groupc/global/networks/default"
  priority      = 1000
  project       = "swift2023groupc"
  source_ranges = ["130.211.0.0/22", "209.85.152.0/22", "209.85.204.0/22", "35.191.0.0/16"]
  target_tags   = ["lb-health-check"]
}
# terraform import google_compute_firewall.default_allow_health_check projects/swift2023groupc/global/firewalls/default-allow-health-check
