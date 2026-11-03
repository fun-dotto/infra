variable "github_owner" {
  default = "fun-dotto"
}

variable "github_app_client_id" {
  description = "GitHub App の Client ID (App ID ではない)"
  type = string
}

variable "github_app_installation_id" {
  type = string
}

variable "github_app_pem_file" {
  type      = string
  sensitive = true
}
