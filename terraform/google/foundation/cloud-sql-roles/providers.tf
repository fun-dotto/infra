# terraform-ci の IAM ユーザー (terraform/google/foundation/cloud-sql/users.tf) で接続する。
# Cloud SQL には SUPERUSER がないため superuser = false にする
provider "postgresql" {
  scheme    = "gcppostgres"
  host      = "swift2023groupc/asia-northeast1/dotto"
  username  = "terraform-ci@swift2023groupc.iam"
  superuser = false

  gcp_iam_impersonate_service_account = "terraform-ci@swift2023groupc.iam.gserviceaccount.com"
}
