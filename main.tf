# main.tf
module "gce-container" {
  source = "terraform-google-modules/container-vm/google"

  container = {
    image = "linuxserver/wireguard"
    env = [
      {
        name  = "PUID"
        value = random_integer.randint.result
      },
      {
        name  = "PGID"
        value = random_integer.randint.result
      },
      {
        name  = "TZ"
        value = var.timezone
      },
      {
        name  = "SERVERPORT"
        value = var.vpn_server_port
      },
      {
        name  = "PEERS"
        value = var.vpn_num_peers
      },
      {
        name  = "PEERDNS"
        value = "auto"
      },
      {
        name  = "INTERNAL_SUBNET"
        value = "10.13.13.0"
      },
      {
        name  = "ALLOWED_IPS"
        value = "0.0.0.0/0"
      },
      {
        name  = "LOG_CONFS"
        value = "true"
      }
    ],

    securityContext = {
      privileged : true
    }

  }
  restart_policy = "Never"
}

resource "random_integer" "randint" {
  min = 1000
  max = 9999
}

resource "google_compute_address" "static" {
  name = "${var.vm_name}-ipv4-address"
}

resource "google_compute_instance" "vm" {
  name         = var.vm_name
  machine_type = var.machine_type
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = module.gce-container.source_image
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.vpn_subnetwork.id
    access_config {
      nat_ip = google_compute_address.static.address
    }
  }

  tags = ["container-vm-example"]

  metadata = {
    gce-container-declaration = module.gce-container.metadata_value
    google-logging-enabled    = "true"
    google-monitoring-enabled = "true"
  }

  labels = {
    container-vm = module.gce-container.vm_container_label
  }

  service_account {
    email = google_service_account.service_account.email
    scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]
  }
}

resource "google_service_account" "service_account" {
  account_id   = "${var.vm_name}-service-account"
  display_name = "${var.vm_name} service account"
}
