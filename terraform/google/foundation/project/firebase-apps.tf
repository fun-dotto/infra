locals {
  firebase_apple_team_id = "64LEQXTB98"

  firebase_apple_apps = {
    default = {
      display_name = "Dotto"
      bundle_id    = "jp.ac.fun.dotto"
      app_store_id = "6471561803"
    }
    dev = {
      display_name = "Dotto Dev"
      bundle_id    = "jp.ac.fun.dotto.dev"
    }
    stg = {
      display_name = "Dotto Stg"
      bundle_id    = "jp.ac.fun.dotto.stg"
    }
    prd = {
      display_name = "Dotto Prd"
      bundle_id    = "jp.ac.fun.dotto.prd"
    }
  }

  firebase_android_apps = {
    default = {
      display_name  = "Dotto"
      package_name  = "jp.ac.fun.dotto"
      sha1_hashes   = ["611fbdf49f5a6fd105a70154b56913a3f32c4773"]
      sha256_hashes = ["47f8579f1722e005514dcd290d996bc0ce420a70f9f40bacbd54a5867aadd2fb"]
    }
    dev = {
      display_name  = "Dotto Dev"
      package_name  = "jp.ac.fun.dotto.dev"
      sha1_hashes   = ["74d3226a1f3925658d212622ca8bfb3eb5e4706c"]
      sha256_hashes = ["b11a9c520515138fd0d42a519f8da0fc4a6e9c63acc30ba18be6476368a17241"]
    }
    stg = {
      display_name  = "Dotto Stg"
      package_name  = "jp.ac.fun.dotto.stg"
      sha1_hashes   = ["68c25913cbd4fc7cd2e1e3c6202b1459417da011"]
      sha256_hashes = ["73f7aa27e01c9b88abc13f3f74f3245f2f7239a473de1bf66a9326c66179d314"]
    }
    prd = {
      display_name  = "Dotto Prd"
      package_name  = "jp.ac.fun.dotto.prd"
      sha1_hashes   = ["4e9dccea9d017d247b9c09660d5d7640f001138a"]
      sha256_hashes = ["2eb403aced6f22c2f9b7f39bf5f6730ea92cacaba3a0511ac89254fc18ab70d4"]
    }
  }

  firebase_web_apps = {
    default = {
      display_name = "Dotto"
    }
    dev = {
      display_name = "Dotto Dev"
    }
    stg = {
      display_name = "Dotto Stg"
    }
    funch = {
      display_name = "Funch"
    }
  }
}

resource "google_firebase_apple_app" "this" {
  provider = google-beta
  for_each = local.firebase_apple_apps

  project      = google_project.default.project_id
  display_name = each.value.display_name
  bundle_id    = each.value.bundle_id
  team_id      = local.firebase_apple_team_id
  app_store_id = lookup(each.value, "app_store_id", null)

  depends_on = [google_firebase_project.default]

  lifecycle {
    prevent_destroy = true
  }
}

resource "google_firebase_android_app" "this" {
  provider = google-beta
  for_each = local.firebase_android_apps

  project       = google_project.default.project_id
  display_name  = each.value.display_name
  package_name  = each.value.package_name
  sha1_hashes   = each.value.sha1_hashes
  sha256_hashes = each.value.sha256_hashes

  depends_on = [google_firebase_project.default]

  lifecycle {
    prevent_destroy = true
  }
}

resource "google_firebase_web_app" "this" {
  provider = google-beta
  for_each = local.firebase_web_apps

  project      = google_project.default.project_id
  display_name = each.value.display_name

  depends_on = [google_firebase_project.default]

  lifecycle {
    prevent_destroy = true
  }
}
