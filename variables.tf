# variables.tf
variable "project_id" {
  description = "The project ID to deploy into"
}

variable "vm_name" {
  description = "Name of the VM to deploy the container onto"
}

variable "machine_type" {
  description = "Machine type of the deployed VM"
}

variable "zone" {
  description = "GCP zone to deploy into"
}

variable "vpn_server_url" {
  description = "Server URL for Wireguard"
}

variable "vpn_server_port" {
  description = "Server port for Wireguard (often 51820)"
}

variable "vpn_num_peers" {
  description = "Number of Wireguard peers to auto-generate"
}

variable "region" {
  description = "GCP region to deploy into"
}

variable "network_name" {
  description = "Name of the network that will be created"
}

variable "subnetwork_name" {
  description = "Name of the subnetwork that will be created"
}

variable "timezone" {
  description = "Timezone for the Wireguard server"
  default     = "America/New_York"
}

variable "peer_dns" {
  description = "DNS setting for connected peers"
  default     = "auto"
}
