variable "name" {
  type = string
}

variable "description" {
  type = string
}

variable "homepage_url" {
  type    = string
  default = ""
}

variable "topics" {
  type    = list(string)
  default = []
}

variable "has_wiki" {
  type    = bool
  default = true
}

variable "allow_merge_commit" {
  type    = bool
  default = true
}

variable "allow_auto_merge" {
  type    = bool
  default = true
}

# デフォルトブランチの Ruleset
variable "ruleset" {
  type = object({
    name                       = optional(string, "Default")
    merge_method               = string
    required_approving_reviews = number
    dismiss_stale_reviews      = optional(bool, true)
    max_entries_to_build       = optional(number, 10)
    # team_id は github_team の id
    required_reviewers     = optional(list(object({ team_id = string, minimum_approvals = number })), [])
    required_status_checks = optional(list(string), [])
  })
}

# Team の slug などのキー => { team_id, permission (pull / triage / push / maintain / admin) }
variable "team_permissions" {
  type    = map(object({ team_id = string, permission = string }))
  default = {}
}

variable "environments" {
  type    = list(string)
  default = []
}

# Variable 名 => 値。null のものは Terraform 管理外とする
variable "variables" {
  type    = map(string)
  default = {}
}

# Environment 名 => { Variable 名 => 値 }。null のものは Terraform 管理外とする
variable "environment_variables" {
  type    = map(map(string))
  default = {}
}

# Secret 名。値は同名の Secret Manager のシークレットに手動で登録する
variable "secrets" {
  type    = set(string)
  default = []
}

# Direct Workload Identity Federation で GitHub Actions に直接付与するプロジェクトのロール
variable "workload_identity_roles" {
  type    = set(string)
  default = []
}

variable "workload_identity_pool_name" {
  type    = string
  default = "projects/107577467292/locations/global/workloadIdentityPools/dotto"
}

variable "google_cloud_project_id" {
  type    = string
  default = "swift2023groupc"
}
