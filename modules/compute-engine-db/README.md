# Compute Engine DB Module

Create VM from instance template.

## Requirements

### Configure a Service Account

In order to execute this module you must have a Service Account with the following roles:

- Compute Admin: `roles/compute.admin`
- Service Account User: `roles/iam.serviceAccountUser`
- Project IAM Admin: `roles/resourcemanager.projectIamAdmin`
- Cloud KMS Admin: `roles/cloudkms.admin`

The [Service Account module](../service_account) can be used to provision a service account with the necessary roles applied.


<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| access\_config | Access configurations, i.e. IPs via which the VM instance can be accessed via the Internet. The networking tier used for configuring this instance. This field can take the following values: PREMIUM or STANDARD. | <pre>list(object({<br>    nat_ip       = string<br>    network_tier = string<br>  }))</pre> | `[]` | no |
| cmek\_project\_id | CMEK project id. | `string` | n/a | yes |
| compute\_service\_account | The Google service account ID. | `string` | `""` | no |
| create\_key | If you want to use an create a key | `bool` | `true` | no |
| deletion\_protection | Enable deletion protection on this instance. Note: you must disable deletion protection before removing the resource, or the instance cannot be deleted and the Terraform run will not complete successfully. | `bool` | `false` | no |
| disk\_encryption\_key | The self link of the encryption key that is stored in Google Cloud KMS to use to encrypt all the disks on this instance | `string` | `""` | no |
| disk\_size\_gb | Boot disk size in GB | `string` | n/a | yes |
| disk\_type | Boot disk type, can be either pd-ssd, local-ssd, or pd-standard | `string` | `"pd-standard"` | no |
| instance\_name | Name of the instance. | `string` | n/a | yes |
| instance\_prefix | Name prefix for the instance template | `string` | n/a | yes |
| key\_name | Name to be used for KMS Key for CMEK | `string` | `"key"` | no |
| key\_rotation\_period | Rotation period in seconds to be used for KMS Key | `string` | n/a | yes |
| keyring\_name | Name to be used for KMS Keyring for CMEK | `string` | n/a | yes |
| labels | Labels provided as a map | `map(string)` | `{}` | no |
| machine\_type | Machine type to create. Note that the instance image must support Confidential VMs | `string` | n/a | yes |
| metadata | Metadata provided as a map | `map(string)` | <pre>{<br>  "serial-port-enable": false<br>}</pre> | no |
| network | The name or self\_link of the network to attach this interface to. Use network attribute for Legacy or Auto subnetted networks and subnetwork for custom subnetted networks. | `string` | n/a | yes |
| num\_instances | Number of instances to create. | `string` | n/a | yes |
| project\_id | The GCP project ID | `string` | n/a | yes |
| region | Region where the instance template should be created. | `string` | n/a | yes |
| roles\_list | roles list for the service account | `list(string)` | `[]` | no |
| sa\_prefix | Name prefix for the service account | `string` | n/a | yes |
| source\_image | Source disk image. Note that the instance image must support Confidential VMs. | `string` | n/a | yes |
| source\_image\_project | Source disk image project. Note that the instance image must support Confidential VMs. | `string` | n/a | yes |
| subnetwork | The name of the subnetwork to attach this interface to. The subnetwork must exist in the same region this instance will be created in. Either network or subnetwork must be provided. | `string` | n/a | yes |
| tags | Network tags, provided as a list | `list(string)` | <pre>[<br>  "db1"<br>]</pre> | no |
| use\_existing\_keyring | If you want to use an existing keyring and don't create a new one -> true | `bool` | n/a | yes |
| zone | Zone where the instances should be created. If not specified, instances will be spread across available zones in the region. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| available\_zones | List of available zones in region |
| instances\_details | List of all details for compute instances |
| instances\_self\_links | List of self-links for compute instances |
| self\_link | Self-link of instance template |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
