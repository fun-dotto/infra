resource "google_service_account" "terraform_ci" {
  account_id   = "terraform-ci"
  display_name = "Terraform CI"
  description  = "GitHub Actions から dotto-infra の Terraform を plan / apply するための SA"
}

# Terraform は project / IAM / SQL / Secret Manager / Storage など全リソースを
# 管理するため、CI 用 SA には owner を付与する。
resource "google_project_iam_member" "terraform_ci" {
  for_each = toset([
    "roles/owner",
  ])

  project = var.google_cloud_project_id
  role    = each.value
  member  = "serviceAccount:${google_service_account.terraform_ci.email}"
}
