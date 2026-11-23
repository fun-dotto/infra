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
      display_name = "Dotto"
      package_name = "jp.ac.fun.dotto"
      sha1_hashes = [
        "611fbdf49f5a6fd105a70154b56913a3f32c4773",
        "108b0e26f04568e33941ca6cdfe8f73140a27be2",
        "53fe9369521065ac32b65d4226ecb0d67d74e783",
      ]
      sha256_hashes = [
        "47f8579f1722e005514dcd290d996bc0ce420a70f9f40bacbd54a5867aadd2fb",
        "9fc8bc063b4123a97463013aec3aa3af6426b98044c4d5369c77cfa3f7561b8c",
        "d109855c74bf2be683127caf2afc86ef2b6da5dcb70b2e15d653ffaae98fd3f2",
      ]
    }
    dev = {
      display_name = "Dotto Dev"
      package_name = "jp.ac.fun.dotto.dev"
      sha1_hashes = [
        "74d3226a1f3925658d212622ca8bfb3eb5e4706c",
        "8b53d5738699ef46eaefe4e8f4cec6f6fb0096c0",
        "bb349d527518f61a7756f05f5b57422cda847139",
        "9a6e0abc53e6c366785afb4fa3919bef5bb86911",
      ]
      sha256_hashes = [
        "b11a9c520515138fd0d42a519f8da0fc4a6e9c63acc30ba18be6476368a17241",
        "b19e821556a6ef6c7644e984967bc762dbf65e04ccf81808369edc80ee5c8888",
        "0a654b632e9d21dad5f9f95c152fcc4c14ed5a609f0be9619d37f2a430a97f50",
        "c1eccd6cb5b9d93f4fa009229d9e1a5b894a6cb402edc04e2aab139260638523",
      ]
    }
    stg = {
      display_name = "Dotto Stg"
      package_name = "jp.ac.fun.dotto.stg"
      sha1_hashes = [
        "68c25913cbd4fc7cd2e1e3c6202b1459417da011",
        "73627b8099260da13a23530f5901b0c256dde5cb",
        "18ab29a8d95b292d8178f38ec3daab7e0f65c2db",
        "b178c3e7eaf572d6022f56d4fadcfe2fd738ee1e",
      ]
      sha256_hashes = [
        "73f7aa27e01c9b88abc13f3f74f3245f2f7239a473de1bf66a9326c66179d314",
        "f612de6ab99472ab69287cd94aa0af8df8f20659f29b05d9719d25daeba61d4c",
        "eae890b509dde2591b1cef36b30fdeb3bd5f20438febd2414f6bcbc52af88f3c",
        "76bc5230fa6a7060c9d2edb6706cc9ab2795fbd5ba2bf3dc3e1e9f9e8a1c502c",
      ]
    }
    prd = {
      display_name = "Dotto Prd"
      package_name = "jp.ac.fun.dotto.prd"
      sha1_hashes = [
        "4e9dccea9d017d247b9c09660d5d7640f001138a",
        "8d6c9a15e8071ad061fce4d6b6c716e0641365e1",
        "f424475c61d071bd8cef78949ccaa0bb31a9b334",
        "a02900e69d31c7840674fc11ece4550105453a1d",
      ]
      sha256_hashes = [
        "2eb403aced6f22c2f9b7f39bf5f6730ea92cacaba3a0511ac89254fc18ab70d4",
        "7a800f10ac5a5d1b0aacc5ee34069af89009adf7bf7f2b4fdc4f6fbac3fa7af1",
        "d454c0c12336d3cc13900d9f9eca3d9bcf91e1dca38c20fd45dcd588a90c346d",
        "8f9d66be765ea0991098d156b5282d5f40d36a5a90bfee7621d62f49b5eca77b",
      ]
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
