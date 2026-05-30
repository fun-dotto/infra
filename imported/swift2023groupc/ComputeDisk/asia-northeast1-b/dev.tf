resource "google_compute_disk" "dev" {
  guest_os_features {
    type = "GVNIC"
  }

  guest_os_features {
    type = "IDPF"
  }

  guest_os_features {
    type = "SEV_CAPABLE"
  }

  guest_os_features {
    type = "SEV_LIVE_MIGRATABLE"
  }

  guest_os_features {
    type = "SEV_LIVE_MIGRATABLE_V2"
  }

  guest_os_features {
    type = "SEV_SNP_CAPABLE"
  }

  guest_os_features {
    type = "SNP_SVSM_CAPABLE"
  }

  guest_os_features {
    type = "TDX_CAPABLE"
  }

  guest_os_features {
    type = "UEFI_COMPATIBLE"
  }

  guest_os_features {
    type = "VIRTIO_SCSI_MULTIQUEUE"
  }

  image = "https://www.googleapis.com/compute/beta/projects/ubuntu-os-cloud/global/images/ubuntu-minimal-2604-resolute-amd64-v20260421"

  labels = {
    managed-by-cnrm = "true"
  }

  licenses                  = ["https://www.googleapis.com/compute/v1/projects/ubuntu-os-cloud/global/licenses/ubuntu-minimal-2604-lts"]
  name                      = "dev"
  physical_block_size_bytes = 4096
  project                   = "swift2023groupc"
  size                      = 10
  type                      = "pd-balanced"
  zone                      = "asia-northeast1-b"
}
# terraform import google_compute_disk.dev projects/swift2023groupc/zones/asia-northeast1-b/disks/dev
