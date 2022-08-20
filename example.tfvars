# example.tfvars
project_id      = "GOOGLE_PROJECT_ID"
vm_name         = "gcp-vpn"
machine_type    = "f1-micro"
region          = "us-central1"
zone            = "us-central1-a"
vpn_server_url  = "your.domain.here"
vpn_server_port = "51820"
vpn_num_peers   = 1
peer_dns        = "8.8.8.8" # Google Public DNS
network_name    = "my-vpn-network"
subnetwork_name = "my-vpn-subnetwork"
