provider "postgresql" {
  scheme    = "gcppostgres"
  host      = "swift2023groupc/asia-northeast1/dotto"
  username  = "terraform-ci@swift2023groupc.iam"
  superuser = false

  gcp_iam_impersonate_service_account = "terraform-ci@swift2023groupc.iam.gserviceaccount.com"
}
