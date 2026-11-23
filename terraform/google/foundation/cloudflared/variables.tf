variable "tfstate_bucket" {
  default = "swift2023groupc-tfstate"
}

variable "image" {
  default = "docker.io/cloudflare/cloudflared:2025.8.1"
}
