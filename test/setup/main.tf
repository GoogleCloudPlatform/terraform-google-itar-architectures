/**
 * Copyright 2019 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

resource "google_assured_workloads_workload" "primary" {
  billing_account   = "billingAccounts/${var.billing_account}"
  compliance_regime = "ITAR"
  display_name      = "ITAR-test-workload"
  location          = "us-central1"
  organization      = var.org_id

  provisioned_resources_parent = "folders/${var.folder_id}"

  resource_settings {
    resource_type = "CONSUMER_FOLDER"
  }
}

locals {
  assured_workload_folder_id       = compact([for resource in google_assured_workloads_workload.primary.resources : resource.resource_type == "CONSUMER_FOLDER" ? resource.resource_id : ""])[0]
  assured_workload_cmek_project_id = compact([for resource in google_assured_workloads_workload.primary.resources : resource.resource_type == "ENCRYPTION_KEYS_PROJECT" ? resource.resource_id : ""])[0]
}

module "project" {
  source  = "terraform-google-modules/project-factory/google"
  version = "~> 14.0"

  name              = "ci-itar-architectures"
  random_project_id = "true"
  org_id            = var.org_id
  folder_id         = local.assured_workload_folder_id
  billing_account   = var.billing_account

  activate_apis = [
    "cloudresourcemanager.googleapis.com",
    "iam.googleapis.com",
    "compute.googleapis.com",
    "vpcaccess.googleapis.com",
    "storage-component.googleapis.com",
    "storage-api.googleapis.com",
    "orgpolicy.googleapis.com",
    "serviceusage.googleapis.com",
    "dns.googleapis.com",
    "cloudkms.googleapis.com",
    "domains.googleapis.com",
    "iamcredentials.googleapis.com",
    "iap.googleapis.com",
    "accesscontextmanager.googleapis.com"
  ]
}
