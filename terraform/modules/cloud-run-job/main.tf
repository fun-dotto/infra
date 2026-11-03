resource "google_service_account" "this" {
  account_id   = var.service_account_id
  display_name = var.service_account_display_name
}

resource "google_project_iam_member" "this" {
  for_each = var.project_roles

  project = var.project_id
  role    = each.value
  member  = "serviceAccount:${google_service_account.this.email}"
}

resource "google_secret_manager_secret_iam_member" "secret_env" {
  for_each = { for env in var.secret_env : env.name => env.secret_id }

  secret_id = each.value
  role      = "roles/secretmanager.secretAccessor"
  member    = "serviceAccount:${google_service_account.this.email}"
}

resource "google_service_account" "scheduler" {
  account_id   = "${var.service_account_id}-scheduler"
  display_name = "${var.service_account_display_name} Scheduler"
}

resource "google_cloud_run_v2_job_iam_member" "invoker" {
  name   = google_cloud_run_v2_job.this.name
  role   = "roles/run.invoker"
  member = "serviceAccount:${google_service_account.scheduler.email}"
}

resource "google_cloud_run_v2_job" "this" {
  deletion_protection = var.deletion_protection

  launch_stage = "GA"
  location     = var.location
  name         = var.job_name

  template {
    template {
      containers {
        command = var.command

        env {
          name  = "DB_IAM_USER"
          value = trimsuffix(google_service_account.this.email, ".gserviceaccount.com")
        }
        env {
          name  = "DB_NAME"
          value = var.cloud_sql.db_name
        }
        env {
          name  = "INSTANCE_CONNECTION_NAME"
          value = var.cloud_sql.instance_connection_name
        }

        dynamic "env" {
          for_each = var.secret_env

          content {
            name = env.value.name
            value_source {
              secret_key_ref {
                secret  = env.value.secret_id
                version = "latest"
              }
            }
          }
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

      service_account = google_service_account.this.email
      timeout         = "900s"
    }
  }

  depends_on = [
    google_secret_manager_secret_iam_member.secret_env,
  ]

  lifecycle {
    ignore_changes = [
      client,
      client_version,
      template[0].labels,
      template[0].template[0].containers[0].image,
    ]
  }
}

resource "google_cloud_scheduler_job" "trigger" {
  name      = "${var.job_name}-trigger"
  schedule  = var.schedule
  time_zone = var.timezone

  http_target {
    http_method = "POST"
    uri         = "https://run.googleapis.com/v2/projects/${google_cloud_run_v2_job.this.project}/locations/${google_cloud_run_v2_job.this.location}/jobs/${google_cloud_run_v2_job.this.name}:run"
    headers = {
      "Content-Type" = "application/json"
    }
    body = base64encode("{}")

    oauth_token {
      service_account_email = google_service_account.scheduler.email
    }
  }
}
