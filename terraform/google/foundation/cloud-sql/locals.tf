locals {
  database_admins = toset([
    "iam@kantacky.com",
    "msyaaa456910@gmail.com",
    "beretta0602@gmail.com",
  ])

  database_developers = toset([
    "axitian882@gmail.com",
    "identityv5656@gmail.com",
    "kaxu123456@gmail.com",
    "tash19695@gmail.com",
    "yamas.jto@gmail.com",
    "yonggoutwitter89@gmail.com",
  ])

  database_service_accounts = toset([
    "academic-svc",
    "academic-svc-dev",
    "academic-svc-stg",
    "admin-api",
    "admin-api-dev",
    "admin-api-stg",
    "announcement-svc",
    "announcement-svc-dev",
    "announcement-svc-stg",
    "app-api",
    "app-api-dev",
    "app-api-stg",
    "bld-irr-noti-job",
    "bld-irr-noti-job-dev",
    "bld-irr-noti-job-stg",
    "import-gtfs-job",
    "import-gtfs-job-dev",
    "import-gtfs-job-stg",
    "noti-user-job",
    "noti-user-job-dev",
    "noti-user-job-stg",
    "user-svc",
    "user-svc-dev",
    "user-svc-stg",
  ])

  # fun-dotto/server の GitHub Actions でマイグレーションを実行する SA の account_id
  # (terraform/google/foundation/iam-workload-identity/service_account_github-actions-server-migrate.tf の account_id と一致させる)
  migrate_dry_run_service_account = "gha-server-migrate-dry-run"
  migrate_apply_service_account   = "gha-server-migrate-apply"
}
