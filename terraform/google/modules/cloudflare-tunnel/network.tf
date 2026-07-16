resource "google_compute_network" "cloudflared" {
  name                    = var.network_name
  auto_create_subnetworks = false

  depends_on = [google_project_service.required]
}

resource "google_compute_subnetwork" "cloudflared" {
  name                     = var.network_name
  ip_cidr_range            = var.subnetwork_cidr
  network                  = google_compute_network.cloudflared.id
  private_ip_google_access = true
  region                   = var.google_cloud_region
}

resource "google_dns_managed_zone" "run_app" {
  name        = "cloud-run-private-access"
  dns_name    = "run.app."
  description = "Resolve Cloud Run default URLs through Private Google Access."
  visibility  = "private"

  private_visibility_config {
    networks {
      network_url = google_compute_network.cloudflared.id
    }
  }

  depends_on = [google_project_service.required]
}

resource "google_dns_record_set" "run_app" {
  name         = "run.app."
  managed_zone = google_dns_managed_zone.run_app.name
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
  name         = "*.run.app."
  managed_zone = google_dns_managed_zone.run_app.name
  type         = "CNAME"
  ttl          = 300
  rrdatas      = ["run.app."]
}
