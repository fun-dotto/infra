resource "google_cloud_run_v2_job" "build_class_change_notifications_job_dev" {
  launch_stage = "GA"
  location     = "asia-northeast1"
  name         = "build-class-change-notifications-job-dev"
  project      = "swift2023groupc"

  template {
    task_count = 1

    template {
      containers {
        command = ["/bin/build-class-change-notifications-job"]

        env {
          name  = "GOOGLE_CLOUD_PROJECT"
          value = "swift2023groupc"
        }

        env {
          name  = "DB_IAM_USER"
          value = "class-change-notif-job-dev@swift2023groupc.iam"
        }

        env {
          name  = "DB_NAME"
          value = "dotto_dev"
        }

        env {
          name  = "INSTANCE_CONNECTION_NAME"
          value = "swift2023groupc:asia-northeast1:dotto"
        }

        image = "asia-northeast1-docker.pkg.dev/swift2023groupc/server/server:59276d31bc45"

        resources {
          limits = {
            cpu    = "1"
            memory = "512Mi"
          }
        }
      }

      execution_environment = "EXECUTION_ENVIRONMENT_GEN2"
      max_retries           = 1
      service_account       = "class-change-notif-job-dev@swift2023groupc.iam.gserviceaccount.com"
      timeout               = "900s"
    }
  }
}
