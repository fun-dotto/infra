resource "google_compute_firewall" "default_allow_health_check_ipv6" {
  allow {
    protocol = "tcp"
  }

  direction     = "INGRESS"
  name          = "default-allow-health-check-ipv6"
  network       = "https://www.googleapis.com/compute/v1/projects/swift2023groupc/global/networks/default"
  priority      = 1000
  project       = "swift2023groupc"
  source_ranges = ["2600:1901:8001::/48", "2600:2d00:1:b029::/64"]
  target_tags   = ["lb-health-check"]
}
# terraform import google_compute_firewall.default_allow_health_check_ipv6 projects/swift2023groupc/global/firewalls/default-allow-health-check-ipv6
