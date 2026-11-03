moved {
  from = google_secret_manager_secret_iam_member.app_dart_define_dev
  to   = google_secret_manager_secret_iam_member.app_dart_define_dev["group:fun-dotto-dev-app@googlegroups.com"]
}

moved {
  from = google_secret_manager_secret_iam_member.app_dart_define_stg
  to   = google_secret_manager_secret_iam_member.app_dart_define_stg["group:fun-dotto-dev-app@googlegroups.com"]
}

moved {
  from = google_secret_manager_secret_iam_member.app_dart_define_prd
  to   = google_secret_manager_secret_iam_member.app_dart_define_prd["group:fun-dotto-dev-app@googlegroups.com"]
}
