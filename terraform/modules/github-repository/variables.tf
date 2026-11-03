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

# Environment 名 => 設定
variable "environments" {
  type = map(object({
    can_admins_bypass = optional(bool, true)
    # 承認者の GitHub ユーザー ID
    reviewer_user_ids = optional(list(number), [])
    # true の場合、デプロイを実行したユーザー自身は承認できない
    prevent_self_review = optional(bool, false)
    # true の場合、保護されたブランチからのみデプロイできる
    protected_branches_only = optional(bool, false)
  }))
  default = {}
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
