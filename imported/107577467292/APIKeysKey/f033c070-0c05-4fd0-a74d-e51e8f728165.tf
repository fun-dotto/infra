resource "google_apikeys_key" "f033c070_0c05_4fd0_a74d_e51e8f728165" {
  display_name = "Browser key (auto created by Firebase)"
  name         = "f033c070-0c05-4fd0-a74d-e51e8f728165"
  project      = "107577467292"

  restrictions {
    api_targets {
      service = "firebasedatabase.googleapis.com"
    }

    api_targets {
      service = "firebasehosting.googleapis.com"
    }

    api_targets {
      service = "firebaserules.googleapis.com"
    }

    api_targets {
      service = "sqladmin.googleapis.com"
    }

    api_targets {
      service = "cloudconfig.googleapis.com"
    }

    api_targets {
      service = "datastore.googleapis.com"
    }

    api_targets {
      service = "fcmregistrations.googleapis.com"
    }

    api_targets {
      service = "firebase.googleapis.com"
    }

    api_targets {
      service = "firebaseappcheck.googleapis.com"
    }

    api_targets {
      service = "firebaseappdistribution.googleapis.com"
    }

    api_targets {
      service = "firebaseapphosting.googleapis.com"
    }

    api_targets {
      service = "firebaseapptesters.googleapis.com"
    }

    api_targets {
      service = "firebasedataconnect.googleapis.com"
    }

    api_targets {
      service = "firebaseinappmessaging.googleapis.com"
    }

    api_targets {
      service = "firebaseinstallations.googleapis.com"
    }

    api_targets {
      service = "firebaseml.googleapis.com"
    }

    api_targets {
      service = "firebaseremoteconfig.googleapis.com"
    }

    api_targets {
      service = "firebaseremoteconfigrealtime.googleapis.com"
    }

    api_targets {
      service = "firebasestorage.googleapis.com"
    }

    api_targets {
      service = "firebasevertexai.googleapis.com"
    }

    api_targets {
      service = "firestore.googleapis.com"
    }

    api_targets {
      service = "identitytoolkit.googleapis.com"
    }

    api_targets {
      service = "logging.googleapis.com"
    }

    api_targets {
      service = "mlkit.googleapis.com"
    }

    api_targets {
      service = "play.googleapis.com"
    }

    api_targets {
      service = "securetoken.googleapis.com"
    }

    api_targets {
      service = "fpnv.googleapis.com"
    }
  }
}
# terraform import google_apikeys_key.f033c070_0c05_4fd0_a74d_e51e8f728165 projects/107577467292/locations/global/keys/f033c070-0c05-4fd0-a74d-e51e8f728165
