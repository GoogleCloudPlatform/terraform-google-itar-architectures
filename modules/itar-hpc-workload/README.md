# ITAR-Aligned HPC Workload

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| access\_level\_name | Access level name of the Access Policy. | `string` | n/a | yes |
| bucket\_lifecycle\_file | File path for GCS lifecycle policy (JSON format) | `string` | n/a | yes |
| cmek\_project\_id | CMEK project id. | `string` | n/a | yes |
| db\_deletion\_protection | Enable deletion protection on this instance. Note: you must disable deletion protection before removing the resource, or the instance cannot be deleted and the Terraform run will not complete successfully. | `bool` | n/a | yes |
| db\_disk\_size\_gb | Boot disk size in GB | `string` | `"50"` | no |
| db\_instance\_name | HPC instance name | `string` | n/a | yes |
| db\_instance\_prefix | value | `string` | `"itar"` | no |
| db\_keyring\_name | Name of keyring | `string` | n/a | yes |
| db\_machine\_type | Machine type to create. Note that the instance image must support Confidential VMs | `string` | n/a | yes |
| db\_num\_instances | Number of instances to create. | `string` | `"1"` | no |
| db\_source\_image | Source disk image. Note that the instance image must support Confidential VMs. | `string` | n/a | yes |
| db\_source\_image\_project | Source disk image project. Note that the instance image must support Confidential VMs. | `string` | n/a | yes |
| db\_tags | Tags for db instance | `list(string)` | n/a | yes |
| db\_use\_existing\_keyring | Whether to use existing keyring or not | `string` | n/a | yes |
| db\_zone | Zone of db instnace | `string` | `null` | no |
| deny\_policy\_name | Name of IAM deny policy | `string` | n/a | yes |
| dmz\_deletion\_protection | Enable deletion protection on this instance. Note: you must disable deletion protection before removing the resource, or the instance cannot be deleted and the Terraform run will not complete successfully. | `bool` | n/a | yes |
| dmz\_disk\_size\_gb | Boot disk size in GB | `string` | `"50"` | no |
| dmz\_instance\_name | HPC instance name | `string` | n/a | yes |
| dmz\_instance\_prefix | value | `string` | `"itar"` | no |
| dmz\_keyring\_name | Name of keyring | `string` | n/a | yes |
| dmz\_machine\_type | Machine type to create. Note that the instance image must support Confidential VMs | `string` | n/a | yes |
| dmz\_nat\_name | Name of the name | `string` | `"dmz-itar-nat"` | no |
| dmz\_network\_name | The name of the hpc cluster VPC network being created | `string` | n/a | yes |
| dmz\_num\_instances | Number of instances to create. | `string` | `"1"` | no |
| dmz\_router\_name | Name of the router | `string` | `"dmz-itar-router"` | no |
| dmz\_router\_region | Name of the router region | `string` | `"us-central1"` | no |
| dmz\_source\_image | Source disk image. Note that the instance image must support Confidential VMs. | `string` | n/a | yes |
| dmz\_source\_image\_project | Source disk image project. Note that the instance image must support Confidential VMs. | `string` | n/a | yes |
| dmz\_subnets | The list of subnets being created | `list(map(string))` | n/a | yes |
| dmz\_tags | Tags for db instance | `list(string)` | n/a | yes |
| dmz\_use\_existing\_keyring | Whether to use existing keyring or not | `string` | n/a | yes |
| dmz\_zone | Zone of db instnace | `string` | `null` | no |
| gce\_keyring\_name | Name of keyring to use for GCE instances | `string` | n/a | yes |
| gcs\_kms\_key\_name | KMS key name | `string` | n/a | yes |
| gcs\_kms\_ring\_name | KMS key ring name | `string` | n/a | yes |
| gcs\_location | Location endpoint (region) for creating bucket | `string` | n/a | yes |
| hpc\_deletion\_protection | Enable deletion protection on this instance. Note: you must disable deletion protection before removing the resource, or the instance cannot be deleted and the Terraform run will not complete successfully. | `bool` | n/a | yes |
| hpc\_disk\_size | HPC disk size | `string` | `"50"` | no |
| hpc\_instance\_name | HPC instance name | `string` | n/a | yes |
| hpc\_instance\_prefix | Instance | `string` | `"itar"` | no |
| hpc\_keyring\_name | Name of keyring | `string` | n/a | yes |
| hpc\_machine\_type | HPC machine type | `string` | `"c2-standard-4"` | no |
| hpc\_nat\_name | Name of the name | `string` | `"hpc-itar-nat"` | no |
| hpc\_network\_name | The name of the hpc cluster VPC network being created | `string` | n/a | yes |
| hpc\_num\_instances | HPC number of instances | `string` | `"1"` | no |
| hpc\_router\_name | Name of the router | `string` | `"hpc-itar-router"` | no |
| hpc\_router\_region | Name of the router region | `string` | `"us-central1"` | no |
| hpc\_source\_image | HPC Source disk image. | `string` | `"hpc-centos-7"` | no |
| hpc\_source\_image\_project | HPC Source disk image project. | `string` | `"cloud-hpc-image-public"` | no |
| hpc\_subnets | The list of subnets being created | `list(map(string))` | n/a | yes |
| hpc\_tags | Tags for HPC | `list(string)` | n/a | yes |
| hpc\_use\_existing\_keyring | Whether to use existing keyring or not | `string` | n/a | yes |
| hpc\_zone | Zone where the instances should be created. If not specified, instances will be spread across available zones in the region. | `string` | `null` | no |
| iap\_members | IAP members | `list(string)` | n/a | yes |
| iap\_name | Name of IAP | `string` | n/a | yes |
| iap\_zone | IAP zone | `string` | `null` | no |
| input\_bucket\_name | Name of the input bucket | `string` | n/a | yes |
| key\_rotation\_period | Rotation period of keyring | `string` | `"7776000s"` | no |
| kms\_prevent\_destroy | Set to true to prevent deletion of KMS keys upon running Terraform destroy | `bool` | `true` | no |
| members | An allowed list of members (users, service accounts). The signed-in identity originating the request must be a part of one of the provided members. If not specified, a request may come from any user (logged in/not logged in, etc.). Formats: user:{emailid}, serviceAccount:{emailid} | `list(string)` | n/a | yes |
| output\_bucket\_name | Name of the output bucket | `string` | n/a | yes |
| parent\_id | The parent of this AccessPolicy in the Cloud Resource Hierarchy. As of now, only organization (org id) are accepted as parent. | `string` | n/a | yes |
| perimeter\_name | Perimeter name of the Access Policy.. | `string` | n/a | yes |
| policy\_name | The policy's name. | `string` | n/a | yes |
| private\_service\_connect\_ip | IP for private service connect | `string` | n/a | yes |
| private\_service\_connect\_name | Name of private service connect | `string` | n/a | yes |
| private\_service\_forwarding\_rule | Name of private service connect forwarding rule | `string` | n/a | yes |
| project\_id | The project ID to host the network in | `string` | n/a | yes |
| region | The name of the dmz VPC network being created | `string` | `"us-central1"` | no |
| sa\_prefix | Name prefix for the service account | `string` | `"itar"` | no |

## Outputs

No output.

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
