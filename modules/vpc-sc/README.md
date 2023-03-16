# Terraform VPC SC Module

This module creates a VPC SC Perimeter for the HPC and DMZ zone.


<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| access\_level\_name | Access level name of the Access Policy. | `string` | n/a | yes |
| members | An allowed list of members (users, service accounts). The signed-in identity originating the request must be a part of one of the provided members. If not specified, a request may come from any user (logged in/not logged in, etc.). Formats: user:{emailid}, serviceAccount:{emailid} | `list(string)` | n/a | yes |
| parent\_id | The parent of this AccessPolicy in the Cloud Resource Hierarchy. As of now, only organization are accepted as parent. | `string` | n/a | yes |
| perimeter\_name | Perimeter name of the Access Policy.. | `string` | n/a | yes |
| policy\_name | The policy's name. | `string` | n/a | yes |
| protected\_project\_numbers | Project id and number of the project INSIDE the regular service perimeter. This map variable expects an "id" for the project id and "number" key for the project number. | `list(string)` | n/a | yes |
| scopes | Define the scope as project (list)  ex: projects/projectnumber | `list(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| access\_level\_name | Access level name of the Access Policy. |
| policy\_id | Resource name of the AccessPolicy. |
| policy\_name | Name of the parent policy |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
