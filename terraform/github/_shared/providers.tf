# Actions の GITHUB_TOKEN では Organization を操作できないため GitHub App で認証する
provider "github" {
  owner = var.github_owner

  app_auth {
    id              = var.github_app_client_id # Client ID を指定する
    installation_id = var.github_app_installation_id
    pem_file        = var.github_app_pem_file
  }
}
