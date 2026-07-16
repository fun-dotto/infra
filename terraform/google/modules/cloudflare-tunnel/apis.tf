resource "google_project_service" "required" {
  for_each = toset([
    "compute.googleapis.com",
    "dns.googleapis.com",
    "run.googleapis.com",
    "secretmanager.googleapis.com",
  ])

  project            = var.google_cloud_project_id
  service            = each.value
  disable_on_destroy = false
}
