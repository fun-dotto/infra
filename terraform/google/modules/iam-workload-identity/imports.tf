import {
  to = google_iam_workload_identity_pool.dotto
  id = "projects/swift2023groupc/locations/global/workloadIdentityPools/dotto"
}

import {
  to = google_iam_workload_identity_pool_provider.github
  id = "projects/swift2023groupc/locations/global/workloadIdentityPools/dotto/providers/github"
}

import {
  to = google_service_account.github_actions
  id = "projects/swift2023groupc/serviceAccounts/github-actions@swift2023groupc.iam.gserviceaccount.com"
}

import {
  to = google_service_account.terraform_ci
  id = "projects/swift2023groupc/serviceAccounts/terraform-ci@swift2023groupc.iam.gserviceaccount.com"
}

import {
  to = google_project_iam_member.github_actions["roles/artifactregistry.writer"]
  id = "swift2023groupc roles/artifactregistry.writer serviceAccount:github-actions@swift2023groupc.iam.gserviceaccount.com"
}

import {
  to = google_project_iam_member.github_actions["roles/iam.serviceAccountUser"]
  id = "swift2023groupc roles/iam.serviceAccountUser serviceAccount:github-actions@swift2023groupc.iam.gserviceaccount.com"
}

import {
  to = google_project_iam_member.github_actions["roles/iam.workloadIdentityUser"]
  id = "swift2023groupc roles/iam.workloadIdentityUser serviceAccount:github-actions@swift2023groupc.iam.gserviceaccount.com"
}

import {
  to = google_project_iam_member.github_actions["roles/run.admin"]
  id = "swift2023groupc roles/run.admin serviceAccount:github-actions@swift2023groupc.iam.gserviceaccount.com"
}

import {
  to = google_project_iam_member.terraform_ci["roles/owner"]
  id = "swift2023groupc roles/owner serviceAccount:terraform-ci@swift2023groupc.iam.gserviceaccount.com"
}

import {
  to = google_service_account_iam_member.github_actions_workload_identity_user["admin-web"]
  id = "projects/swift2023groupc/serviceAccounts/github-actions@swift2023groupc.iam.gserviceaccount.com roles/iam.workloadIdentityUser principal://iam.googleapis.com/projects/107577467292/locations/global/workloadIdentityPools/dotto/subject/fun-dotto/admin-web"
}

import {
  to = google_service_account_iam_member.github_actions_workload_identity_user["app"]
  id = "projects/swift2023groupc/serviceAccounts/github-actions@swift2023groupc.iam.gserviceaccount.com roles/iam.workloadIdentityUser principal://iam.googleapis.com/projects/107577467292/locations/global/workloadIdentityPools/dotto/subject/fun-dotto/app"
}

import {
  to = google_service_account_iam_member.github_actions_workload_identity_user["server"]
  id = "projects/swift2023groupc/serviceAccounts/github-actions@swift2023groupc.iam.gserviceaccount.com roles/iam.workloadIdentityUser principal://iam.googleapis.com/projects/107577467292/locations/global/workloadIdentityPools/dotto/subject/fun-dotto/server"
}

import {
  to = google_service_account_iam_member.github_actions_workload_identity_user["web"]
  id = "projects/swift2023groupc/serviceAccounts/github-actions@swift2023groupc.iam.gserviceaccount.com roles/iam.workloadIdentityUser principal://iam.googleapis.com/projects/107577467292/locations/global/workloadIdentityPools/dotto/subject/fun-dotto/web"
}

import {
  to = google_service_account_iam_member.terraform_ci_workload_identity_user["infra"]
  id = "projects/swift2023groupc/serviceAccounts/terraform-ci@swift2023groupc.iam.gserviceaccount.com roles/iam.workloadIdentityUser principal://iam.googleapis.com/projects/107577467292/locations/global/workloadIdentityPools/dotto/subject/fun-dotto/infra"
}
