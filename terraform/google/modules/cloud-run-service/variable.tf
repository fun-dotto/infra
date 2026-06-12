variable "service_envs" {
  type        = map(map(string))
  description = "Cloud Run サービスごとの環境変数。キーはリソース名。"
}
