import {
  to = google_service_account.academic_api_dev
  id = "projects/swift2023groupc/serviceAccounts/academic-api-dev@swift2023groupc.iam.gserviceaccount.com"
}

import {
  to = google_service_account.batch_jobs_job
  id = "projects/swift2023groupc/serviceAccounts/batch-jobs-job@swift2023groupc.iam.gserviceaccount.com"
}

import {
  to = google_service_account.class_change_batch_job
  id = "projects/swift2023groupc/serviceAccounts/class-change-batch-job@swift2023groupc.iam.gserviceaccount.com"
}

import {
  to = google_service_account.class_change_batch_scheduler
  id = "projects/swift2023groupc/serviceAccounts/class-change-batch-scheduler@swift2023groupc.iam.gserviceaccount.com"
}

import {
  to = google_service_account.class_change_notif_job_dev
  id = "projects/swift2023groupc/serviceAccounts/class-change-notif-job-dev@swift2023groupc.iam.gserviceaccount.com"
}

import {
  to = google_service_account.dispatch_notif_job_dev
  id = "projects/swift2023groupc/serviceAccounts/dispatch-notif-job-dev@swift2023groupc.iam.gserviceaccount.com"
}

import {
  to = google_service_account.fastlane_supply
  id = "projects/swift2023groupc/serviceAccounts/fastlane-supply@swift2023groupc.iam.gserviceaccount.com"
}

import {
  to = google_service_account.firebase_adminsdk_v653f
  id = "projects/swift2023groupc/serviceAccounts/firebase-adminsdk-v653f@swift2023groupc.iam.gserviceaccount.com"
}

import {
  to = google_service_account.firebase_app_distribution
  id = "projects/swift2023groupc/serviceAccounts/firebase-app-distribution@swift2023groupc.iam.gserviceaccount.com"
}

import {
  to = google_service_account.functions_get_fun_schedule
  id = "projects/swift2023groupc/serviceAccounts/functions-get-fun-schedule@swift2023groupc.iam.gserviceaccount.com"
}

import {
  to = google_service_account.github_actions
  id = "projects/swift2023groupc/serviceAccounts/github-actions@swift2023groupc.iam.gserviceaccount.com"
}

import {
  to = google_service_account.migrate_job_dev
  id = "projects/swift2023groupc/serviceAccounts/migrate-job-dev@swift2023groupc.iam.gserviceaccount.com"
}

import {
  to = google_service_account.scheduler_dev
  id = "projects/swift2023groupc/serviceAccounts/scheduler-dev@swift2023groupc.iam.gserviceaccount.com"
}

# Project-level IAM roles granted to each service account

import {
  to = google_project_iam_member.academic_api_dev["roles/cloudsql.client"]
  id = "swift2023groupc roles/cloudsql.client serviceAccount:academic-api-dev@swift2023groupc.iam.gserviceaccount.com"
}

import {
  to = google_project_iam_member.academic_api_dev["roles/cloudsql.instanceUser"]
  id = "swift2023groupc roles/cloudsql.instanceUser serviceAccount:academic-api-dev@swift2023groupc.iam.gserviceaccount.com"
}

import {
  to = google_project_iam_member.batch_jobs_job["projects/swift2023groupc/roles/fcmSender"]
  id = "swift2023groupc projects/swift2023groupc/roles/fcmSender serviceAccount:batch-jobs-job@swift2023groupc.iam.gserviceaccount.com"
}

import {
  to = google_project_iam_member.batch_jobs_job["roles/cloudsql.client"]
  id = "swift2023groupc roles/cloudsql.client serviceAccount:batch-jobs-job@swift2023groupc.iam.gserviceaccount.com"
}

import {
  to = google_project_iam_member.batch_jobs_job["roles/cloudsql.instanceUser"]
  id = "swift2023groupc roles/cloudsql.instanceUser serviceAccount:batch-jobs-job@swift2023groupc.iam.gserviceaccount.com"
}

import {
  to = google_project_iam_member.class_change_batch_job["roles/cloudsql.client"]
  id = "swift2023groupc roles/cloudsql.client serviceAccount:class-change-batch-job@swift2023groupc.iam.gserviceaccount.com"
}

import {
  to = google_project_iam_member.class_change_batch_job["roles/cloudsql.instanceUser"]
  id = "swift2023groupc roles/cloudsql.instanceUser serviceAccount:class-change-batch-job@swift2023groupc.iam.gserviceaccount.com"
}

import {
  to = google_project_iam_member.class_change_notif_job_dev["roles/cloudsql.client"]
  id = "swift2023groupc roles/cloudsql.client serviceAccount:class-change-notif-job-dev@swift2023groupc.iam.gserviceaccount.com"
}

import {
  to = google_project_iam_member.class_change_notif_job_dev["roles/cloudsql.instanceUser"]
  id = "swift2023groupc roles/cloudsql.instanceUser serviceAccount:class-change-notif-job-dev@swift2023groupc.iam.gserviceaccount.com"
}

import {
  to = google_project_iam_member.dispatch_notif_job_dev["projects/swift2023groupc/roles/fcmSender"]
  id = "swift2023groupc projects/swift2023groupc/roles/fcmSender serviceAccount:dispatch-notif-job-dev@swift2023groupc.iam.gserviceaccount.com"
}

import {
  to = google_project_iam_member.dispatch_notif_job_dev["roles/cloudsql.client"]
  id = "swift2023groupc roles/cloudsql.client serviceAccount:dispatch-notif-job-dev@swift2023groupc.iam.gserviceaccount.com"
}

import {
  to = google_project_iam_member.dispatch_notif_job_dev["roles/cloudsql.instanceUser"]
  id = "swift2023groupc roles/cloudsql.instanceUser serviceAccount:dispatch-notif-job-dev@swift2023groupc.iam.gserviceaccount.com"
}

import {
  to = google_project_iam_member.firebase_adminsdk_v653f["roles/cloudconfig.admin"]
  id = "swift2023groupc roles/cloudconfig.admin serviceAccount:firebase-adminsdk-v653f@swift2023groupc.iam.gserviceaccount.com"
}

import {
  to = google_project_iam_member.firebase_adminsdk_v653f["roles/cloudfunctions.admin"]
  id = "swift2023groupc roles/cloudfunctions.admin serviceAccount:firebase-adminsdk-v653f@swift2023groupc.iam.gserviceaccount.com"
}

import {
  to = google_project_iam_member.firebase_adminsdk_v653f["roles/firebase.analyticsAdmin"]
  id = "swift2023groupc roles/firebase.analyticsAdmin serviceAccount:firebase-adminsdk-v653f@swift2023groupc.iam.gserviceaccount.com"
}

import {
  to = google_project_iam_member.firebase_adminsdk_v653f["roles/firebase.appDistributionSdkServiceAgent"]
  id = "swift2023groupc roles/firebase.appDistributionSdkServiceAgent serviceAccount:firebase-adminsdk-v653f@swift2023groupc.iam.gserviceaccount.com"
}

import {
  to = google_project_iam_member.firebase_adminsdk_v653f["roles/firebase.sdkAdminServiceAgent"]
  id = "swift2023groupc roles/firebase.sdkAdminServiceAgent serviceAccount:firebase-adminsdk-v653f@swift2023groupc.iam.gserviceaccount.com"
}

import {
  to = google_project_iam_member.firebase_adminsdk_v653f["roles/firebaseabt.admin"]
  id = "swift2023groupc roles/firebaseabt.admin serviceAccount:firebase-adminsdk-v653f@swift2023groupc.iam.gserviceaccount.com"
}

import {
  to = google_project_iam_member.firebase_adminsdk_v653f["roles/firebaseappcheck.admin"]
  id = "swift2023groupc roles/firebaseappcheck.admin serviceAccount:firebase-adminsdk-v653f@swift2023groupc.iam.gserviceaccount.com"
}

import {
  to = google_project_iam_member.firebase_adminsdk_v653f["roles/firebaseauth.admin"]
  id = "swift2023groupc roles/firebaseauth.admin serviceAccount:firebase-adminsdk-v653f@swift2023groupc.iam.gserviceaccount.com"
}

import {
  to = google_project_iam_member.firebase_adminsdk_v653f["roles/firebasedatabase.admin"]
  id = "swift2023groupc roles/firebasedatabase.admin serviceAccount:firebase-adminsdk-v653f@swift2023groupc.iam.gserviceaccount.com"
}

import {
  to = google_project_iam_member.firebase_adminsdk_v653f["roles/iam.serviceAccountTokenCreator"]
  id = "swift2023groupc roles/iam.serviceAccountTokenCreator serviceAccount:firebase-adminsdk-v653f@swift2023groupc.iam.gserviceaccount.com"
}

import {
  to = google_project_iam_member.firebase_adminsdk_v653f["roles/storage.admin"]
  id = "swift2023groupc roles/storage.admin serviceAccount:firebase-adminsdk-v653f@swift2023groupc.iam.gserviceaccount.com"
}

import {
  to = google_project_iam_member.firebase_app_distribution["roles/firebase.appDistributionSdkServiceAgent"]
  id = "swift2023groupc roles/firebase.appDistributionSdkServiceAgent serviceAccount:firebase-app-distribution@swift2023groupc.iam.gserviceaccount.com"
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
  to = google_project_iam_member.migrate_job_dev["roles/cloudsql.client"]
  id = "swift2023groupc roles/cloudsql.client serviceAccount:migrate-job-dev@swift2023groupc.iam.gserviceaccount.com"
}

import {
  to = google_project_iam_member.migrate_job_dev["roles/cloudsql.instanceUser"]
  id = "swift2023groupc roles/cloudsql.instanceUser serviceAccount:migrate-job-dev@swift2023groupc.iam.gserviceaccount.com"
}

# Service account IAM policies (who can act on each service account)

import {
  to = google_service_account_iam_member.class_change_batch_scheduler_token_creator
  id = "projects/swift2023groupc/serviceAccounts/class-change-batch-scheduler@swift2023groupc.iam.gserviceaccount.com roles/iam.serviceAccountTokenCreator serviceAccount:service-107577467292@gcp-sa-cloudscheduler.iam.gserviceaccount.com"
}

import {
  to = google_service_account_iam_member.scheduler_dev_token_creator
  id = "projects/swift2023groupc/serviceAccounts/scheduler-dev@swift2023groupc.iam.gserviceaccount.com roles/iam.serviceAccountTokenCreator serviceAccount:service-107577467292@gcp-sa-cloudscheduler.iam.gserviceaccount.com"
}

import {
  to = google_service_account_iam_member.functions_get_fun_schedule_admin
  id = "projects/swift2023groupc/serviceAccounts/functions-get-fun-schedule@swift2023groupc.iam.gserviceaccount.com roles/iam.serviceAccountAdmin user:TIGERtora7571@gmail.com"
}
