module "job" {
  source = "../../../../modules/cloud-run-job"

  project_id = "swift2023groupc"
  location   = "asia-northeast1"

  job_name                               = "class-change-batch"
  service_account_id                     = "class-change-batch-job"
  service_account_display_name           = "Class Change Batch Cloud Run Job"
  scheduler_service_account_id           = "class-change-batch-scheduler"
  scheduler_service_account_display_name = "Class Change Batch Cloud Scheduler"
  project_roles = [
    "roles/cloudsql.client",
    "roles/cloudsql.instanceUser",
  ]

  image               = "asia-northeast1-docker.pkg.dev/swift2023groupc/class-change-batch/class-change-batch:latest"
  deletion_protection = false
  max_retries         = 1

  cloud_sql = {
    db_name                  = "dotto"
    instance_connection_name = "swift2023groupc:asia-northeast1:dotto"
  }

  # Secret は別プロジェクトにあり Terraform から IAM を管理できないため、参照のみ行う
  manage_secret_iam = false
  secret_env = [
    {
      name      = "USER_ID"
      secret_id = "projects/secret-494111/secrets/class-change-batch-user-id"
    },
    {
      name      = "USER_PASSWORD"
      secret_id = "projects/secret-494111/secrets/class-change-batch-user-password"
    },
  ]

  schedule              = "0 17 * * *"
  timezone              = "Asia/Tokyo"
  scheduler_description = "Trigger class change batch Cloud Run Job"
}
