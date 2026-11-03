resource "google_service_account" "github_actions_app" {
  account_id   = "github-actions-app"
  display_name = "GitHub Actions (app)"
  description  = "fun-dotto/app の GitHub Actions 専用 SA"
}

resource "google_project_iam_member" "github_actions_app" {
  for_each = toset([
    "roles/firebase.appDistributionSdkServiceAgent", # Firebase App Distribution へのアップロード
    "roles/firebase.viewer",                         # Firebase 設定ファイルの取得
  ])

  project = var.google_cloud_project_id
  role    = each.value
  member  = "serviceAccount:${google_service_account.github_actions_app.email}"
}

resource "google_service_account_iam_member" "github_actions_app_workload_identity_user" {
  for_each = toset([
    "app",
  ])

  service_account_id = google_service_account.github_actions_app.name
  role               = "roles/iam.workloadIdentityUser"
  member             = "principal://iam.googleapis.com/${google_iam_workload_identity_pool.dotto.name}/subject/${var.owner}/${each.value}"
}
