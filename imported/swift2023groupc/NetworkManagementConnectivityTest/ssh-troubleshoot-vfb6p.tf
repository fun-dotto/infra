resource "google_network_management_connectivity_test" "ssh_troubleshoot_vfb6p" {
  description = "This connectivity test is created by 'gcloud compute ssh --troubleshoot'"

  destination {
    instance   = "projects/swift2023groupc/zones/asia-northeast1-b/instances/dev"
    ip_address = "34.85.64.115"
    port       = 22
  }

  labels = {
    managed-by-cnrm = "true"
  }

  name     = "ssh-troubleshoot-vfb6p"
  project  = "swift2023groupc"
  protocol = "TCP"

  source {
    ip_address   = "86.48.12.189"
    network_type = "INTERNET"
  }
}
# terraform import google_network_management_connectivity_test.ssh_troubleshoot_vfb6p projects/swift2023groupc/locations/global/connectivityTests/ssh-troubleshoot-vfb6p
