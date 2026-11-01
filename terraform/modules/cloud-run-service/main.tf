locals {
  # Cloud Run の env は順序を持つため、順序を変えると新しいリビジョンが作られる
  env = concat(var.env, var.cloud_sql == null ? [] : [
    {
      name      = "DB_IAM_USER"
      value     = trimsuffix(google_service_account.this.email, ".gserviceaccount.com")
      secret_id = null
    },
    {
      name      = "DB_NAME"
      value     = var.cloud_sql.db_name
      secret_id = null
    },
    {
      name      = "INSTANCE_CONNECTION_NAME"
      value     = var.cloud_sql.instance_connection_name
      secret_id = null
    },
  ])
}

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

resource "google_secret_manager_secret_iam_member" "env" {
  for_each = { for env in var.env : env.name => env.secret_id if env.secret_id != null }

  secret_id = "projects/${var.project_id}/secrets/${each.value}"
  role      = "roles/secretmanager.secretAccessor"
  member    = "serviceAccount:${google_service_account.this.email}"
}

resource "google_cloud_run_v2_service" "this" {
  ingress              = var.ingress
  invoker_iam_disabled = var.invoker_iam_disabled
  default_uri_disabled = var.default_uri_disabled

  deletion_protection = var.deletion_protection

  launch_stage = "GA"
  location     = var.location
  name         = var.service_name

  template {
    execution_environment = null

    containers {
      command = var.command

      dynamic "env" {
        for_each = local.env

        content {
          name  = env.value.name
          value = env.value.value

          dynamic "value_source" {
            for_each = env.value.secret_id == null ? [] : [env.value.secret_id]

            content {
              secret_key_ref {
                secret  = value_source.value
                version = "latest"
              }
            }
          }
        }
      }

      image = var.image

      ports {
        container_port = 8080
        name           = "http1"
      }

      resources {
        cpu_idle = true

        limits = {
          cpu    = "1"
          memory = "512Mi"
        }

        startup_cpu_boost = true
      }

      startup_probe {
        failure_threshold     = 1
        initial_delay_seconds = 0
        period_seconds        = 240

        tcp_socket {
          port = 8080
        }

        timeout_seconds = 240
      }
    }

    max_instance_request_concurrency = 80

    scaling {
      max_instance_count = var.max_instance_count
      min_instance_count = var.min_instance_count
    }

    dynamic "vpc_access" {
      for_each = var.vpc_access == null ? [] : [var.vpc_access]

      content {
        egress = vpc_access.value.egress

        network_interfaces {
          network    = vpc_access.value.network
          subnetwork = vpc_access.value.subnetwork
        }
      }
    }

    service_account = google_service_account.this.email
    timeout         = "300s"
  }

  traffic {
    percent = 100
    type    = "TRAFFIC_TARGET_ALLOCATION_TYPE_LATEST"
  }

  depends_on = [
    google_secret_manager_secret_iam_member.env,
  ]

  lifecycle {
    ignore_changes = [
      client,
      client_version,
      labels,
      template[0].labels,
      template[0].containers[0].image,
    ]
  }
}
