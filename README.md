# ITAR-Aligned Google Cloud Architectures

## Description
The modules in this Terraform blueprint show how to implement common architectures aligned with ITAR compliance requirements. 
The following architectures are available in the [modules](./modules/) directory:
- [ITAR HPC Workload](./modules/itar-hpc-workload/)

See the following documentation for more information on specific requirements for adhering to ITAR on Google Cloud. 

## Documentation
- [Google Cloud: Restrictions and limitations for ITAR](https://cloud.google.com/assured-workloads/docs/itar-restrictions-limitations)

## Usage
See specific usage examples for each of the following architectures in the [examples](./examples/) directory:
- [ITAR HPC Workload Example](./examples/itar_hpc_workload_example/)

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Requirements

These sections describe requirements for using this module.

### Software

The following dependencies must be available:

- [Terraform][terraform] v0.13
- [Terraform Provider for GCP][terraform-provider-gcp] plugin v3.0

### Service Account

Refer to the documentation for individual submodules in the [modules](./modules/) directory for specific IAM requirements.

The [Project Factory module][project-factory-module] and the
[IAM module][iam-module] may be used in combination to provision a
service account with the necessary roles applied.

### APIs

A project with the following APIs enabled must be used to host the
resources of this module:

- `cloudresourcemanager.googleapis.com`
- `iam.googleapis.com`
- `compute.googleapis.com`
- `vpcaccess.googleapis.com`
- `storage-component.googleapis.com`
- `storage-api.googleapis.com`
- `orgpolicy.googleapis.com`
- `serviceusage.googleapis.com`
- `dns.googleapis.com`
- `cloudkms.googleapis.com`
- `domains.googleapis.com`
- `iamcredentials.googleapis.com`
- `iap.googleapis.com`
- `accesscontextmanager.googleapis.com`

The [Project Factory module][project-factory-module] can be used to
provision a project with the necessary APIs enabled.

## Contributing

Refer to the [contribution guidelines](./CONTRIBUTING.md) for
information on contributing to this module.

[iam-module]: https://registry.terraform.io/modules/terraform-google-modules/iam/google
[project-factory-module]: https://registry.terraform.io/modules/terraform-google-modules/project-factory/google
[terraform-provider-gcp]: https://www.terraform.io/docs/providers/google/index.html
[terraform]: https://www.terraform.io/downloads.html

## Security Disclosures

Please see our [security disclosure process](./SECURITY.md).
