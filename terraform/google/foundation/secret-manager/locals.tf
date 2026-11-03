locals {
  # app の Secret Manager のシークレットへのアクセスを許可するメンバー
  app_secret_accessor_members = toset([
    "group:fun-dotto-dev-app@googlegroups.com",
    # fun-dotto/app の GitHub Actions 専用 SA (iam-workload-identity で管理)
    "serviceAccount:github-actions-app@${var.google_cloud_project_id}.iam.gserviceaccount.com",
  ])
}
