resource "google_network_management_connectivity_test" "ssh_troubleshoot_iodl8" {
  description = "This connectivity test is created by 'gcloud compute ssh --troubleshoot'"

  destination {
    instance   = "projects/swift2023groupc/zones/asia-northeast1-b/instances/dev"
    ip_address = "35.189.144.129"
    port       = 22
  }

  labels = {
    managed-by-cnrm = "true"
  }

  name     = "ssh-troubleshoot-iodl8"
  project  = "swift2023groupc"
  protocol = "TCP"

  source {
    ip_address   = "194.195.89.237"
    network_type = "INTERNET"
  }
}
# terraform import google_network_management_connectivity_test.ssh_troubleshoot_iodl8 projects/swift2023groupc/locations/global/connectivityTests/ssh-troubleshoot-iodl8
