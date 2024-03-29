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

locals {
  int_required_roles = [
    "roles/owner"
  ]
  int_required_roles_kms = [
    "roles/cloudkms.admin"
  ]
  int_required_roles_org = [
    "roles/resourcemanager.organizationAdmin",
    "roles/iam.denyAdmin",
    "roles/accesscontextmanager.policyAdmin",
  ]
}

resource "google_service_account" "int_test" {
  project      = module.project.project_id
  account_id   = "ci-account"
  display_name = "ci-account"
}

resource "google_project_iam_member" "int_test" {
  for_each = toset(local.int_required_roles)

  project = module.project.project_id
  role    = each.value
  member  = "serviceAccount:${google_service_account.int_test.email}"
}

resource "google_project_iam_member" "int_test_kms_proj" {
  for_each = toset(local.int_required_roles_kms)

  project = local.assured_workload_cmek_project_number
  role    = each.value
  member  = "serviceAccount:${google_service_account.int_test.email}"
}

resource "google_organization_iam_member" "int_test_org" {
  for_each = toset(local.int_required_roles_org)

  org_id = var.org_id
  role   = each.value
  member = "serviceAccount:${google_service_account.int_test.email}"
}

resource "google_service_account_key" "int_test" {
  service_account_id = google_service_account.int_test.id
}
