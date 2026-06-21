resource "google_cloud_run_v2_job" "build_irregular_notification_job" {
  launch_stage = "GA"
  location     = var.google_cloud_region
  name         = var.service_name

  template {
    template {
      containers {
        command = [
          "/bin/build-class-change-notifications-job",
        ]

        env {
          name  = "DB_IAM_USER"
          value = trimsuffix(google_service_account.build_irregular_notification_job.email, ".gserviceaccount.com")
        }
        env {
          name  = "DB_NAME"
          value = var.db_name
        }
        env {
          name  = "INSTANCE_CONNECTION_NAME"
          value = var.instance_connection_name
        }

        image = var.image

        resources {
          limits = {
            cpu    = "1"
            memory = "512Mi"
          }
        }
      }

      max_retries = 0

      service_account = google_service_account.build_irregular_notification_job.email
      timeout         = "900s"
    }
  }

  lifecycle {
    ignore_changes = [
      client,
      client_version,
      template[0].labels,
      template[0].template[0].containers[0].image,
    ]
  }
}
