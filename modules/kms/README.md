# KMS Module

Create Keyrings and Keys using Terraform

## Requirements

### Configure a Service Account

In order to execute this module you must have a Service Account with the following roles:

- Cloud KMS Admin: `roles/cloudkms.admin`
- Project IAM Admin: `roles/resourcemanager.projectIamAdmin`

The [Service Account module](../service_account) can be used to provision a service account with the necessary roles applied.


<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| decrypters | List of comma-separated owners for each key declared in set\_decrypters\_for. | `list(string)` | `[]` | no |
| encrypters | List of comma-separated owners for each key declared in set\_encrypters\_for. | `list(string)` | `[]` | no |
| key\_algorithm | The algorithm to use when creating a version based on this template. See the https://cloud.google.com/kms/docs/reference/rest/v1/CryptoKeyVersionAlgorithm for possible inputs. | `string` | `"GOOGLE_SYMMETRIC_ENCRYPTION"` | no |
| key\_protection\_level | The protection level to use when creating a version based on this template. Default value: "SOFTWARE" Possible values: ["SOFTWARE", "HSM"] | `string` | `"SOFTWARE"` | no |
| key\_rotation\_period | n/a | `string` | `"7776000s"` | no |
| keyring | Keyring name. | `string` | n/a | yes |
| keys | Key names. | `list(string)` | `[]` | no |
| labels | Labels, provided as a map | `map(string)` | `{}` | no |
| location | Location for the keyring. | `string` | n/a | yes |
| owners | List of comma-separated owners for each key declared in set\_owners\_for. | `list(string)` | `[]` | no |
| prevent\_destroy | Set the prevent\_destroy lifecycle attribute on keys. | `bool` | `true` | no |
| project\_id | Project id where the keyring will be created. | `string` | n/a | yes |
| set\_decrypters\_for | Name of keys for which decrypters will be set. | `list(string)` | `[]` | no |
| set\_encrypters\_for | Name of keys for which encrypters will be set. | `list(string)` | `[]` | no |
| set\_owners\_for | Name of keys for which owners will be set. | `list(string)` | `[]` | no |
| use\_existing\_keyring | If you want to use an existing keyring and don't create a new one -> true | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| keyring | Self link of the keyring. |
| keys | Map of key name => key self link. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
