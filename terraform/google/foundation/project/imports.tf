locals {
  import_firebase_apple_app_ids = {
    default = "1:107577467292:ios:f2e02b1b0cf3bdea06e859"
    dev     = "1:107577467292:ios:af2df46aff3df68506e859"
    stg     = "1:107577467292:ios:b60af28764a55b0a06e859"
    prd     = "1:107577467292:ios:db9fcaa9ded4130706e859"
  }

  import_firebase_android_app_ids = {
    default = "1:107577467292:android:bf5758604cdceb8506e859"
    dev     = "1:107577467292:android:e07ef0167a67daf106e859"
    stg     = "1:107577467292:android:99fa38c96f4496aa06e859"
    prd     = "1:107577467292:android:fbc3e8fc5e706c0906e859"
  }

  import_firebase_web_app_ids = {
    default = "1:107577467292:web:5dc6af0a958bb41d06e859"
    dev     = "1:107577467292:web:b36425fca7ba429206e859"
    stg     = "1:107577467292:web:e5ba5a744664fb7306e859"
    funch   = "1:107577467292:web:9e50b1fcb6a58d4006e859"
  }
}

import {
  for_each = local.import_firebase_apple_app_ids
  to       = google_firebase_apple_app.this[each.key]
  id       = "projects/${var.google_cloud_project_id}/iosApps/${each.value}"
}

import {
  for_each = local.import_firebase_android_app_ids
  to       = google_firebase_android_app.this[each.key]
  id       = "projects/${var.google_cloud_project_id}/androidApps/${each.value}"
}

import {
  for_each = local.import_firebase_web_app_ids
  to       = google_firebase_web_app.this[each.key]
  id       = "projects/${var.google_cloud_project_id}/webApps/${each.value}"
}
