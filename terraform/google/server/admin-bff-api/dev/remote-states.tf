data "terraform_remote_state" "academic_service" {
  backend = "gcs"

  config = {
    bucket = "swift2023groupc-tfstate"
    prefix = "server/academic-service-dev"
  }
}

data "terraform_remote_state" "announcement_service" {
  backend = "gcs"

  config = {
    bucket = "swift2023groupc-tfstate"
    prefix = "server/announcement-service-dev"
  }
}

data "terraform_remote_state" "user_service" {
  backend = "gcs"

  config = {
    bucket = "swift2023groupc-tfstate"
    prefix = "server/user-service-dev"
  }
}
