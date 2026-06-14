variable "github_owner" {
  description = "GitHub の Organization 名。"
  default     = "fun-dotto"
}

variable "github_repository" {
  description = "対象リポジトリ名。"
  default     = "infra"
}

variable "google_cloud_project_name" {}

variable "google_cloud_billing_account" {
  description = "請求先アカウント ID。Secret として登録する。"
  sensitive   = true
}

variable "production_reviewer_ids" {
  description = "production environment の必須レビュアー（GitHub ユーザー ID の数値）。"
  type        = list(number)
}
