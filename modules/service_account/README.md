# Service account Module

## Requirements

### Configure a Service Account

In order to execute this module you must have a Service Account with the following roles:

- Service Account Admin: `roles/iam.serviceAccountAdmin`


<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| account\_id | The service account id. | `string` | n/a | yes |
| description | The service account description. | `string` | `""` | no |
| display\_name | The service account display name. | `string` | `""` | no |
| project\_id | The ID of the project in which the service account will be created. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| account\_id | The service account id. |
| email | The service account email. |
| id | The service account id in this format projects/{{project}}/serviceAccounts/{{email}}. |
| name | The service account name. |
| service\_account\_private\_key | Service account private key. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
