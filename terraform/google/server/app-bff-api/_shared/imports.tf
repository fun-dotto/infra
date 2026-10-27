moved {
  from = google_cloud_run_v2_service.app_api
  to   = google_cloud_run_v2_service.app_bff_api
}

moved {
  from = google_service_account.app_api
  to   = google_service_account.app_bff_api
}

moved {
  from = google_project_iam_member.app_api
  to   = google_project_iam_member.app_bff_api
}
