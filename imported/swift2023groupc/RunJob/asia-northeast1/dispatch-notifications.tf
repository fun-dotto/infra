resource "google_cloud_run_v2_job" "dispatch_notifications" {
  launch_stage = "GA"
  location     = "asia-northeast1"
  name         = "dispatch-notifications"
  project      = "swift2023groupc"

  template {
    task_count = 1

    template {
      containers {
        command = ["/bin/dispatch-notifications"]

        env {
          name  = "GOOGLE_CLOUD_PROJECT"
          value = "swift2023groupc"
        }

        env {
          name  = "DB_NAME"
          value = "dotto"
        }

        env {
          name  = "DB_IAM_USER"
          value = "batch-jobs-job@swift2023groupc.iam"
        }

        env {
          name  = "INSTANCE_CONNECTION_NAME"
          value = "swift2023groupc:asia-northeast1:dotto"
        }

        image = "asia-northeast1-docker.pkg.dev/swift2023groupc/batch-jobs/batch-jobs:latest"

        resources {
          limits = {
            cpu    = "1"
            memory = "512Mi"
          }
        }
      }

      execution_environment = "EXECUTION_ENVIRONMENT_GEN2"
      max_retries           = 1
      service_account       = "batch-jobs-job@swift2023groupc.iam.gserviceaccount.com"
      timeout               = "15m0s"
    }
  }
}
# terraform import google_cloud_run_v2_job.dispatch_notifications projects/swift2023groupc/locations/asia-northeast1/jobs/dispatch-notifications
