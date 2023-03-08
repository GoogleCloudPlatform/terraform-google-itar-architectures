# Simple Example

This example illustrates how to use the `itar-architectures` module.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| assured\_workload\_cmek\_project\_id | The ID of the Encryption Key project created by Assured Workloads. | `string` | n/a | yes |
| org\_id | The Google Cloud Organizaiton ID, needed to set up VPC-SC. | `string` | n/a | yes |
| project\_id | The ID of the project in which to provision resources. | `string` | n/a | yes |
| region | The Cloud region to use | `string` | `"us-central1"` | no |
| sa\_email | Deployment service account email, for inclusing in Access Context Manager access level | `string` | n/a | yes |

## Outputs

No output.

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

To provision this example, run the following from within this directory:
- `terraform init` to get the plugins
- `terraform plan` to see the infrastructure plan
- `terraform apply` to apply the infrastructure build
- `terraform destroy` to destroy the built infrastructure
