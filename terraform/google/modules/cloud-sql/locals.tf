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
    "yamas.jto@gmail.com",
    "yonggoutwitter89@gmail.com",
  ])

  database_service_accounts = toset([
    "academic-svc",
    "academic-svc-dev",
    "academic-svc-stg",
    "announcement-svc",
    "announcement-svc-dev",
    "announcement-svc-stg",
    "bld-irr-noti-job",
    "bld-irr-noti-job-dev",
    "bld-irr-noti-job-stg",
    "funch-svc",
    "funch-svc-dev",
    "funch-svc-stg",
    "noti-user-job",
    "noti-user-job-dev",
    "noti-user-job-stg",
    "user-svc",
    "user-svc-dev",
    "user-svc-stg",
  ])
}
