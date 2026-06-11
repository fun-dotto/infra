variable "google_cloud_project_id" {}

variable "google_cloud_region" {}

variable "service_envs" {
  type        = map(map(string))
  description = "Cloud Run サービスごとの環境変数。キーはリソース名。"
}
