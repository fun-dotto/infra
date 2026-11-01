output "network_name" {
  description = "The name of the VPC network."
  value       = google_compute_network.dotto.name
}

output "cloud_run_subnetwork_name" {
  description = "The name of the subnetwork used for Cloud Run Direct VPC egress."
  value       = google_compute_subnetwork.cloud_run.name
}
