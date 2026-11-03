locals {
  project_id = "swift2023groupc"
  location   = "asia-northeast1"

  job_service_account       = "class-change-batch-job@${local.project_id}.iam.gserviceaccount.com"
  scheduler_service_account = "class-change-batch-scheduler@${local.project_id}.iam.gserviceaccount.com"
}

import {
  to = module.job.google_service_account.this
  id = "projects/${local.project_id}/serviceAccounts/${local.job_service_account}"
}

import {
  for_each = toset([
    "roles/cloudsql.client",
    "roles/cloudsql.instanceUser",
  ])

  to = module.job.google_project_iam_member.this[each.value]
  id = "${local.project_id} ${each.value} serviceAccount:${local.job_service_account}"
}

import {
  to = module.job.google_service_account.scheduler
  id = "projects/${local.project_id}/serviceAccounts/${local.scheduler_service_account}"
}

import {
  to = module.job.google_cloud_run_v2_job.this
  id = "projects/${local.project_id}/locations/${local.location}/jobs/class-change-batch"
}

import {
  to = module.job.google_cloud_run_v2_job_iam_member.invoker
  id = "projects/${local.project_id}/locations/${local.location}/jobs/class-change-batch roles/run.invoker serviceAccount:${local.scheduler_service_account}"
}

import {
  to = module.job.google_cloud_scheduler_job.trigger
  id = "projects/${local.project_id}/locations/${local.location}/jobs/class-change-batch-trigger"
}
