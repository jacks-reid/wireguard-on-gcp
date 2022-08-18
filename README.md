# Wireguard VPN on Google Cloud Compute Engine

This repository leverages Google Cloud's capability to deploy a container directly on a Compute Engine VM to run a Wireguard VPN server for personal use.

## Usage

Use Terraform to automatically create the infrastructure needed to host the Wireguard VPN server. Make a copy of the `example.tfvars` file and edit the file to your liking:

```sh
cp example.tfvars myvalues.tfvars
```

Now run Terraform referencing your new variables file:

```sh
terraform apply --auto-approve -var-file=myvalues.tfvars
```

SSH to your newly created virtual machine from within the Google Cloud console and scan the QR code automatically generated with your Wireguard app.

```sh
# get the name of the container started
docker ps
# get the QR code from the container logs
docker logs $CONTAINER_NAME
```

Done! 

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | n/a |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_gce-container"></a> [gce-container](#module\_gce-container) | terraform-google-modules/container-vm/google | n/a |

## Resources

| Name | Type |
|------|------|
| [google_compute_address.static](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_address) | resource |
| [google_compute_firewall.allow_iap_ssh](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_firewall) | resource |
| [google_compute_firewall.allow_vpn_port](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_firewall) | resource |
| [google_compute_instance.vm](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_instance) | resource |
| [google_compute_network.vpn_network](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_network) | resource |
| [google_compute_subnetwork.vpn_subnetwork](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_subnetwork) | resource |
| [google_service_account.service_account](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account) | resource |
| [random_integer.randint](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/integer) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_machine_type"></a> [machine\_type](#input\_machine\_type) | Machine type of the deployed VM | `any` | n/a | yes |
| <a name="input_network_name"></a> [network\_name](#input\_network\_name) | Name of the network that will be created | `any` | n/a | yes |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | The project ID to deploy into | `any` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | GCP region to deploy into | `any` | n/a | yes |
| <a name="input_subnetwork_name"></a> [subnetwork\_name](#input\_subnetwork\_name) | Name of the subnetwork that will be created | `any` | n/a | yes |
| <a name="input_vm_name"></a> [vm\_name](#input\_vm\_name) | Name of the VM to deploy the container onto | `any` | n/a | yes |
| <a name="input_vpn_num_peers"></a> [vpn\_num\_peers](#input\_vpn\_num\_peers) | Number of Wireguard peers to auto-generate | `any` | n/a | yes |
| <a name="input_vpn_server_port"></a> [vpn\_server\_port](#input\_vpn\_server\_port) | Server port for Wiregard (often 51820) | `any` | n/a | yes |
| <a name="input_zone"></a> [zone](#input\_zone) | GCP zone to deploy into | `any` | n/a | yes |
