resource "google_compute_instance" "dev" {
  boot_disk {
    auto_delete = true
    device_name = "dev"

    initialize_params {
      image = "https://www.googleapis.com/compute/beta/projects/ubuntu-os-cloud/global/images/ubuntu-minimal-2604-resolute-amd64-v20260421"
      size  = 10
      type  = "pd-balanced"
    }

    mode   = "READ_WRITE"
    source = "https://www.googleapis.com/compute/v1/projects/swift2023groupc/zones/asia-northeast1-b/disks/dev"
  }

  confidential_instance_config {
    enable_confidential_compute = false
  }

  labels = {
    managed-by-cnrm = "true"
  }

  machine_type = "e2-medium"
  name         = "dev"

  network_interface {
    access_config {
      network_tier = "PREMIUM"
    }

    network            = "https://www.googleapis.com/compute/v1/projects/swift2023groupc/global/networks/default"
    network_ip         = "10.146.0.3"
    stack_type         = "IPV4_ONLY"
    subnetwork         = "https://www.googleapis.com/compute/v1/projects/swift2023groupc/regions/asia-northeast1/subnetworks/default"
    subnetwork_project = "swift2023groupc"
  }

  project = "swift2023groupc"

  reservation_affinity {
    type = "ANY_RESERVATION"
  }

  scheduling {
    automatic_restart   = true
    on_host_maintenance = "MIGRATE"
    provisioning_model  = "STANDARD"
  }

  service_account {
    email  = "107577467292-compute@developer.gserviceaccount.com"
    scopes = ["https://www.googleapis.com/auth/devstorage.read_only", "https://www.googleapis.com/auth/logging.write", "https://www.googleapis.com/auth/monitoring.write", "https://www.googleapis.com/auth/service.management.readonly", "https://www.googleapis.com/auth/servicecontrol", "https://www.googleapis.com/auth/trace.append"]
  }

  shielded_instance_config {
    enable_integrity_monitoring = true
    enable_vtpm                 = true
  }

  zone = "asia-northeast1-b"
}
# terraform import google_compute_instance.dev projects/swift2023groupc/zones/asia-northeast1-b/instances/dev
