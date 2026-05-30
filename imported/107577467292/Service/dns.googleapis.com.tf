resource "google_project_service" "dns_googleapis_com" {
  project = "107577467292"
  service = "dns.googleapis.com"
}
# terraform import google_project_service.dns_googleapis_com 107577467292/dns.googleapis.com
