variable "network_name" {
  default = "cloudflared"
}

variable "subnetwork_cidr" {
  description = "CIDR used by Direct VPC egress from the cloudflared worker pool."
  default     = "10.10.0.0/28"
}

variable "worker_pool_name" {
  default = "cloudflared"
}

variable "cloudflared_image" {
  description = "Pin this to a digest when promoting the tunnel to production."
  default     = "cloudflare/cloudflared:latest"
}

variable "tunnel_token_secret_id" {
  default = "cloudflared-token"
}

variable "tunnel_token_secret_version" {
  description = "Secret Manager version containing the remotely managed Cloudflare Tunnel token."
  default     = "latest"
}
