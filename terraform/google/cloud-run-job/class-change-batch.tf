resource "google_cloud_run_v2_job" "class_change_batch" {
  launch_stage = "GA"
  location     = "asia-northeast1"
  name         = "class-change-batch"
  project      = "swift2023groupc"

  template {
    task_count = 1

    template {
      containers {
        env {
          name = "USER_ID"

          value_source {
            secret_key_ref {
              secret  = "projects/secret-494111/secrets/class-change-batch-user-id"
              version = "latest"
            }
          }
        }

        env {
          name  = "DB_NAME"
          value = "dotto"
        }

        env {
          name = "USER_PASSWORD"

          value_source {
            secret_key_ref {
              secret  = "projects/secret-494111/secrets/class-change-batch-user-password"
              version = "latest"
            }
          }
        }

        env {
          name  = "INSTANCE_CONNECTION_NAME"
          value = "swift2023groupc:asia-northeast1:dotto"
        }

        env {
          name  = "DB_IAM_USER"
          value = "class-change-batch-job@swift2023groupc.iam"
        }

        image = "asia-northeast1-docker.pkg.dev/swift2023groupc/class-change-batch/class-change-batch:latest"

        resources {
          limits = {
            cpu    = "1"
            memory = "512Mi"
          }
        }
      }

      execution_environment = "EXECUTION_ENVIRONMENT_GEN2"
      max_retries           = 1
      service_account       = "class-change-batch-job@swift2023groupc.iam.gserviceaccount.com"
      timeout               = "900s"
    }
  }
}
