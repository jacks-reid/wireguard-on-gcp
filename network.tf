# network.tf
resource "google_compute_subnetwork" "vpn_subnetwork" {
  name          = var.subnetwork_name
  ip_cidr_range = "10.2.0.0/16"
  region        = var.region
  network       = google_compute_network.vpn_network.id
}

resource "google_compute_network" "vpn_network" {
  name                    = var.network_name
  auto_create_subnetworks = false
}

resource "google_compute_firewall" "allow_iap_ssh" {
  name      = "allow-iap-ssh"
  network   = google_compute_network.vpn_network.name
  direction = "INGRESS"

  source_ranges = ["35.235.240.0/20"]
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  target_service_accounts = [google_service_account.service_account.email]
}

resource "google_compute_firewall" "allow_vpn_port" {
  name      = "allow-vpn-port"
  network   = google_compute_network.vpn_network.name
  direction = "INGRESS"

  source_ranges = ["0.0.0.0/0"]

  allow {
    protocol = "udp"
    ports    = [ var.vpn_server_port ]
  }
}
