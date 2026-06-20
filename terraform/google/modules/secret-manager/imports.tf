import {
  to = google_secret_manager_secret.app_dart_define_dev
  id = "projects/swift2023groupc/secrets/app_dart_define_dev"
}

import {
  to = google_secret_manager_secret.app_dart_define_stg
  id = "projects/swift2023groupc/secrets/app_dart_define_stg"
}

import {
  to = google_secret_manager_secret.app_dart_define_prd
  id = "projects/swift2023groupc/secrets/app_dart_define_prd"
}

import {
  to = google_secret_manager_secret.app_fastlane_env
  id = "projects/swift2023groupc/secrets/app_fastlane_env"
}

# Secret-level IAM members (who can access each secret)

import {
  to = google_secret_manager_secret_iam_member.app_dart_define_dev
  id = "projects/swift2023groupc/secrets/app_dart_define_dev roles/secretmanager.secretAccessor group:fun-dotto-dev-app@googlegroups.com"
}

import {
  to = google_secret_manager_secret_iam_member.app_dart_define_stg
  id = "projects/swift2023groupc/secrets/app_dart_define_stg roles/secretmanager.secretAccessor group:fun-dotto-dev-app@googlegroups.com"
}

import {
  to = google_secret_manager_secret_iam_member.app_dart_define_prd
  id = "projects/swift2023groupc/secrets/app_dart_define_prd roles/secretmanager.secretAccessor group:fun-dotto-dev-app@googlegroups.com"
}
