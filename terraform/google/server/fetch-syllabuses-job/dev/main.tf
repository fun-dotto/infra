module "job" {
  source = "../../../../modules/cloud-run-job"

  project_id = "swift2023groupc"
  location   = "asia-northeast1"

  job_name                     = "fetch-syllabuses-job-dev"
  service_account_id           = "fetch-syl-job-dev"
  service_account_display_name = "Fetch Syllabuses Job (Dev)"
  project_roles = [
    "roles/cloudsql.client",
    "roles/cloudsql.instanceUser",
    "roles/logging.logWriter",
  ]

  command             = ["/bin/fetch-syllabuses-job"]
  image               = "asia-northeast1-docker.pkg.dev/swift2023groupc/github-actions/server:latest"
  deletion_protection = false

  timeout = "3600s"

  cloud_sql = {
    db_name                  = "dotto_dev"
    instance_connection_name = "swift2023groupc:asia-northeast1:dotto"
  }

  schedule = "0 1 * * 0"
  timezone = "Asia/Tokyo"
}
