import {
  to = google_secret_manager_secret.app_dart_define_development
  id = "projects/swift2023groupc/secrets/app_dart_define_development"
}

import {
  to = google_secret_manager_secret.app_dart_define_production
  id = "projects/swift2023groupc/secrets/app_dart_define_production"
}

import {
  to = google_secret_manager_secret.app_env_fastlane_android
  id = "projects/swift2023groupc/secrets/app_env_fastlane_android"
}

import {
  to = google_secret_manager_secret.app_env_fastlane_ios
  id = "projects/swift2023groupc/secrets/app_env_fastlane_ios"
}

# Secret-level IAM members (who can access each secret)

import {
  to = google_secret_manager_secret_iam_member.app_dart_define_development
  id = "projects/swift2023groupc/secrets/app_dart_define_development roles/secretmanager.secretAccessor group:fun-dotto-dev-app@googlegroups.com"
}

import {
  to = google_secret_manager_secret_iam_member.app_dart_define_production
  id = "projects/swift2023groupc/secrets/app_dart_define_production roles/secretmanager.secretAccessor group:fun-dotto-dev-app@googlegroups.com"
}

import {
  to = google_secret_manager_secret_iam_member.app_env_fastlane_android
  id = "projects/swift2023groupc/secrets/app_env_fastlane_android roles/secretmanager.secretAccessor group:fun-dotto-dev-app@googlegroups.com"
}

import {
  to = google_secret_manager_secret_iam_member.app_env_fastlane_ios
  id = "projects/swift2023groupc/secrets/app_env_fastlane_ios roles/secretmanager.secretAccessor group:fun-dotto-dev-app@googlegroups.com"
}
