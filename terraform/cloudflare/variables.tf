variable "environments" {
  type    = list(string)
  default = ["dev", "stg", "prd"]
}

# GitHub Actions では Secret の CLOUDFLARE_GITHUB_IDP_CLIENT_SECRET を TF_VAR_ で渡す
variable "github_identity_provider_client_secret" {
  description = "Cloudflare Access の GitHub ログインに使う GitHub OAuth App の client secret"
  type        = string
  sensitive   = true
}
