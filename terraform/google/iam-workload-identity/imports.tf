import {
  to = google_iam_workload_identity_pool.dotto
  id = "projects/swift2023groupc/locations/global/workloadIdentityPools/dotto"
}

import {
  to = google_iam_workload_identity_pool_provider.github
  id = "projects/swift2023groupc/locations/global/workloadIdentityPools/dotto/providers/github"
}

import {
  to = google_service_account_iam_member.github_actions_workload_identity_user["academic-api"]
  id = "projects/swift2023groupc/serviceAccounts/github-actions@swift2023groupc.iam.gserviceaccount.com roles/iam.workloadIdentityUser principal://iam.googleapis.com/projects/107577467292/locations/global/workloadIdentityPools/dotto/subject/fun-dotto/academic-api"
}

import {
  to = google_service_account_iam_member.github_actions_workload_identity_user["admin-bff-api"]
  id = "projects/swift2023groupc/serviceAccounts/github-actions@swift2023groupc.iam.gserviceaccount.com roles/iam.workloadIdentityUser principal://iam.googleapis.com/projects/107577467292/locations/global/workloadIdentityPools/dotto/subject/fun-dotto/admin-bff-api"
}

import {
  to = google_service_account_iam_member.github_actions_workload_identity_user["announcement-api"]
  id = "projects/swift2023groupc/serviceAccounts/github-actions@swift2023groupc.iam.gserviceaccount.com roles/iam.workloadIdentityUser principal://iam.googleapis.com/projects/107577467292/locations/global/workloadIdentityPools/dotto/subject/fun-dotto/announcement-api"
}

import {
  to = google_service_account_iam_member.github_actions_workload_identity_user["app-bff-api"]
  id = "projects/swift2023groupc/serviceAccounts/github-actions@swift2023groupc.iam.gserviceaccount.com roles/iam.workloadIdentityUser principal://iam.googleapis.com/projects/107577467292/locations/global/workloadIdentityPools/dotto/subject/fun-dotto/app-bff-api"
}

import {
  to = google_service_account_iam_member.github_actions_workload_identity_user["dotto-admin-web"]
  id = "projects/swift2023groupc/serviceAccounts/github-actions@swift2023groupc.iam.gserviceaccount.com roles/iam.workloadIdentityUser principal://iam.googleapis.com/projects/107577467292/locations/global/workloadIdentityPools/dotto/subject/fun-dotto/dotto-admin-web"
}

import {
  to = google_service_account_iam_member.github_actions_workload_identity_user["dotto-web"]
  id = "projects/swift2023groupc/serviceAccounts/github-actions@swift2023groupc.iam.gserviceaccount.com roles/iam.workloadIdentityUser principal://iam.googleapis.com/projects/107577467292/locations/global/workloadIdentityPools/dotto/subject/fun-dotto/dotto-web"
}

import {
  to = google_service_account_iam_member.github_actions_workload_identity_user["funch-api"]
  id = "projects/swift2023groupc/serviceAccounts/github-actions@swift2023groupc.iam.gserviceaccount.com roles/iam.workloadIdentityUser principal://iam.googleapis.com/projects/107577467292/locations/global/workloadIdentityPools/dotto/subject/fun-dotto/funch-api"
}

import {
  to = google_service_account_iam_member.github_actions_workload_identity_user["user-api"]
  id = "projects/swift2023groupc/serviceAccounts/github-actions@swift2023groupc.iam.gserviceaccount.com roles/iam.workloadIdentityUser principal://iam.googleapis.com/projects/107577467292/locations/global/workloadIdentityPools/dotto/subject/fun-dotto/user-api"
}
