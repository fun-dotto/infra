locals {
  database_developers = toset([
    "beretta0602@gmail.com",
    "iam@kantacky.com",
    "msyaaa456910@gmail.com",
    "axitian882@gmail.com",
    "identityv5656@gmail.com",
    "kaxu123456@gmail.com",
    "tash19695@gmail.com",
    "yamas.jto@gmail.com",
    "yonggoutwitter89@gmail.com",
  ])

  # アプリ実行時の SA。環境ごとに dotto_service_<env> ロールへ所属させる。
  # prd の SA はサフィックスなし
  database_service_accounts_by_environment = {
    dev = toset([
      "admin-api-dev",
      "app-api-dev",
      "bld-irr-noti-job-dev",
      "bld-subj-job-dev",
      "fetch-syl-job-dev",
      "import-gtfs-job-dev",
      "noti-user-job-dev",
    ])
    stg = toset([
      "admin-api-stg",
      "app-api-stg",
      "bld-irr-noti-job-stg",
      "bld-subj-job-stg",
      "fetch-syl-job-stg",
      "import-gtfs-job-stg",
      "noti-user-job-stg",
    ])
    prd = toset([
      "admin-api",
      "app-api",
      "bld-irr-noti-job",
      "bld-subj-job",
      "fetch-syl-job",
      "import-gtfs-job",
      "noti-user-job",
    ])
  }

  # SA の account_id => 所属させるロール (dotto_service_<env>)
  database_service_account_roles = merge([
    for environment, accounts in local.database_service_accounts_by_environment : {
      for account in accounts : account => "dotto_service_${environment}"
    }
  ]...)

  database_migrate_environments = toset(["dev", "stg", "prd"])

  # fun-dotto/server の GitHub Actions でマイグレーションを実行する SA の account_id
  # (terraform/google/foundation/iam-workload-identity/service_account_github-actions-server-migrate.tf の account_id から末尾の -<env> を除いたものと一致させる)
  migrate_dry_run_service_account_prefix = "gha-server-migrate-dry-run"
  migrate_apply_service_account_prefix   = "gha-server-migrate-apply"
}
