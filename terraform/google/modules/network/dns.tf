# VPC 内から *.run.app を private.googleapis.com (Private Google Access) 経由で解決させ、
# ingress: internal の Cloud Run に VPC 経由で到達できるようにする
resource "google_dns_managed_zone" "run_app" {
  name       = "run-app"
  dns_name   = "run.app."
  visibility = "private"

  private_visibility_config {
    networks {
      network_url = google_compute_network.dotto.id
    }
  }
}

resource "google_dns_record_set" "run_app" {
  managed_zone = google_dns_managed_zone.run_app.name
  name         = google_dns_managed_zone.run_app.dns_name
  type         = "A"
  ttl          = 300
  rrdatas = [
    "199.36.153.8",
    "199.36.153.9",
    "199.36.153.10",
    "199.36.153.11",
  ]
}

resource "google_dns_record_set" "run_app_wildcard" {
  managed_zone = google_dns_managed_zone.run_app.name
  name         = "*.${google_dns_managed_zone.run_app.dns_name}"
  type         = "A"
  ttl          = 300
  rrdatas      = google_dns_record_set.run_app.rrdatas
}
