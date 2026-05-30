resource "google_apikeys_key" "7036183f_0672_4832_9689_8617fca8cdd8" {
  display_name = "Browser key (auto created by Firebase)"
  name         = "7036183f-0672-4832-9689-8617fca8cdd8"
  project      = "107577467292"

  restrictions {
    api_targets {
      service = "firebaseappdistribution.googleapis.com"
    }

    api_targets {
      service = "firebasehosting.googleapis.com"
    }

    api_targets {
      service = "firebasedatabase.googleapis.com"
    }

    browser_key_restrictions {
      allowed_referrers = ["https://hope.fun.ac.jp/*", "https://swift2023groupc.web.app/*", "https://swift2023groupc.firebaseapp.com/*", "swift2023groupc.firebaseapp.com/*", "swift2023groupc.appspot.com/*"]
    }
  }
}
# terraform import google_apikeys_key.7036183f_0672_4832_9689_8617fca8cdd8 projects/107577467292/locations/global/keys/7036183f-0672-4832-9689-8617fca8cdd8
