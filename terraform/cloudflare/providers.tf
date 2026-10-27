# API Token は環境変数 CLOUDFLARE_API_TOKEN で渡す
provider "cloudflare" {}

provider "google" {
  billing_project       = var.google_cloud_project_id
  project               = var.google_cloud_project_id
  region                = var.google_cloud_region
  user_project_override = true
}
