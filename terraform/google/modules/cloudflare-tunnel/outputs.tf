output "network_id" {
  value = google_compute_network.cloudflared.id
}

output "worker_pool_id" {
  value = google_cloud_run_v2_worker_pool.cloudflared.id
}

output "tunnel_token_secret_id" {
  value = google_secret_manager_secret.tunnel_token.secret_id
}
