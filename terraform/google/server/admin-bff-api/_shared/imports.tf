moved {
  from = google_cloud_run_v2_service.admin_api
  to   = google_cloud_run_v2_service.admin_bff_api
}

moved {
  from = google_service_account.admin_api
  to   = google_service_account.admin_bff_api
}

moved {
  from = google_project_iam_member.admin_api
  to   = google_project_iam_member.admin_bff_api
}
