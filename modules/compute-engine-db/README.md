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
| can\_ip\_forward | Enable IP forwarding, for NAT instances for example | `string` | `"false"` | no |
| compute\_service\_account | The Google service account ID. | `string` | `""` | no |
| create\_key | If you want to use an create a key | `bool` | `true` | no |
| disk\_encryption\_key | The self link of the encryption key that is stored in Google Cloud KMS to use to encrypt all the disks on this instance | `string` | `""` | no |
| disk\_size\_gb | Boot disk size in GB | `string` | `"100"` | no |
| disk\_type | Boot disk type, can be either pd-ssd, local-ssd, or pd-standard | `string` | `"pd-standard"` | no |
| instance\_prefix | Name prefix for the instance template | `string` | `"instance-template-"` | no |
| key\_name | Name to be used for KMS Key for CMEK | `string` | `"key"` | no |
| key\_rotation\_period | Rotation period in seconds to be used for KMS Key | `string` | `"7776000s"` | no |
| keyring\_name | Name to be used for KMS Keyring for CMEK | `string` | `"keyring-compute"` | no |
| labels | Labels provided as a map | `map(string)` | `{}` | no |
| machine\_type | Machine type to create, e.g. n1-standard-1 | `string` | `"n1-standard-1"` | no |
| metadata | Metadata provided as a map | `map(string)` | `{}` | no |
| network | The name or self\_link of the network to attach this interface to. Use network attribute for Legacy or Auto subnetted networks and subnetwork for custom subnetted networks. | `string` | `""` | no |
| num\_instances | Number of instances to create. | `string` | `"1"` | no |
| project\_id | The GCP project ID | `string` | n/a | yes |
| region | Region where the instance template should be created. | `string` | `"us-east1"` | no |
| roles\_list | roles list for the service account | `list(string)` | `[]` | no |
| sa\_prefix | Name prefix for the service account | `string` | `"default"` | no |
| source\_image | Source disk image. If neither source\_image nor source\_image\_family is specified, defaults to the latest public CentOS image. | `string` | `""` | no |
| startup\_script | User startup script to run when instances spin up | `string` | `""` | no |
| subnetwork | The name of the subnetwork to attach this interface to. The subnetwork must exist in the same region this instance will be created in. Either network or subnetwork must be provided. | `string` | `""` | no |
| tags | Network tags, provided as a list | `list(string)` | n/a | yes |
| terraform\_service\_account | Service account email of the account to impersonate to run Terraform. | `string` | n/a | yes |
| use\_existing\_keyring | If you want to use an existing keyring and don't create a new one -> true | `bool` | `false` | no |
| zone | Zone where the instances should be created. If not specified, instances will be spread across available zones in the region. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| available\_zones | List of available zones in region |
| instances\_details | List of all details for compute instances |
| instances\_self\_links | List of self-links for compute instances |
| self\_link | Self-link of instance template |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
