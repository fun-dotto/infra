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

  # サービス単位とリビジョン単位 (template.scaling) の両方に同じ値を設定する
  # min_instance_schedules を指定した場合、サービス単位の min は Cloud Scheduler が書き換え、リビジョン単位の min は 0 にする
  scaling {
    max_instance_count = var.max_instance_count
    min_instance_count = var.min_instance_count
  }

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
      min_instance_count = length(var.min_instance_schedules) == 0 ? var.min_instance_count : 0
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
      # min_instance_schedules を使うサービスでは Cloud Scheduler が書き換えるため、作成後は Terraform で管理しない
      # (lifecycle は動的に切り替えられないため全サービスで ignore する)
      scaling[0].min_instance_count,
      template[0].labels,
      template[0].containers[0].image,
    ]
  }
}

resource "google_service_account" "scaler" {
  count = length(var.min_instance_schedules) == 0 ? 0 : 1

  account_id   = "${var.service_account_id}-scaler"
  display_name = "${var.service_account_display_name} Scaler"
}

# サービスの更新には実行 SA の actAs が必要
resource "google_service_account_iam_member" "scaler_act_as" {
  count = length(var.min_instance_schedules) == 0 ? 0 : 1

  service_account_id = google_service_account.this.name
  role               = "roles/iam.serviceAccountUser"
  member             = "serviceAccount:${google_service_account.scaler[0].email}"
}

resource "google_cloud_run_v2_service_iam_member" "scaler" {
  count = length(var.min_instance_schedules) == 0 ? 0 : 1

  name     = google_cloud_run_v2_service.this.name
  location = google_cloud_run_v2_service.this.location
  role     = "roles/run.developer"
  member   = "serviceAccount:${google_service_account.scaler[0].email}"
}

# サービス単位の scaling のみ更新するため、新しいリビジョンは作られない
resource "google_cloud_scheduler_job" "min_instance" {
  for_each = { for s in var.min_instance_schedules : s.name => s }

  name      = "${var.service_name}-min-instance-${each.key}"
  schedule  = each.value.schedule
  time_zone = var.timezone

  http_target {
    http_method = "PATCH"
    uri         = "https://run.googleapis.com/v2/${google_cloud_run_v2_service.this.id}?updateMask=scaling.minInstanceCount"
    headers = {
      "Content-Type" = "application/json"
    }
    body = base64encode(jsonencode({
      scaling = {
        minInstanceCount = each.value.min_instance_count
      }
    }))

    oauth_token {
      service_account_email = google_service_account.scaler[0].email
    }
  }

  depends_on = [
    google_service_account_iam_member.scaler_act_as,
    google_cloud_run_v2_service_iam_member.scaler,
  ]
}
