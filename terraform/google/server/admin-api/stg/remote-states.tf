data "terraform_remote_state" "cloudflare" {
  backend = "gcs"

  config = {
    bucket = "swift2023groupc-tfstate"
    prefix = "cloudflare"
  }
}

# TODO: 仮で BFF のバイナリを動かすためだけに必要。統合後の API には不要なので削除する
data "terraform_remote_state" "academic_service" {
  backend = "gcs"

  config = {
    bucket = "swift2023groupc-tfstate"
    prefix = "server/academic-service-stg"
  }
}

# TODO: 仮で BFF のバイナリを動かすためだけに必要。統合後の API には不要なので削除する
data "terraform_remote_state" "announcement_service" {
  backend = "gcs"

  config = {
    bucket = "swift2023groupc-tfstate"
    prefix = "server/announcement-service-stg"
  }
}

# TODO: 仮で BFF のバイナリを動かすためだけに必要。統合後の API には不要なので削除する
data "terraform_remote_state" "user_service" {
  backend = "gcs"

  config = {
    bucket = "swift2023groupc-tfstate"
    prefix = "server/user-service-stg"
  }
}
