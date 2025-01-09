/**
 * Copyright 2023 Google LLC
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


#This module will create access policy which is a container for AccessLevels (which define the necessary attributes to use GCP services) and ServicePerimeters (which define regions of services able to freely pass data within a perimeter)
resource "google_access_context_manager_access_policy" "access_policy" {
  provider = google
  parent   = "organizations/${var.parent_id}"
  title    = var.policy_name
  scopes   = var.scopes
}

#This module will be used to add/give access to members who will not be restricted by the access level context policy and will be able to access the storage service API and storage buckets
module "access_level_members" {
  source  = "terraform-google-modules/vpc-service-controls/google//modules/access_level"
  version = "~> 6.2.0"

  policy  = google_access_context_manager_access_policy.access_policy.name
  name    = "access_members"
  members = var.members
}

#This will create a reguler service perimeter for google cloud storage API, which will restrict allusers to access storage buckets and only give access to selected members
module "regular_service_perimeter_1" {
  source  = "terraform-google-modules/vpc-service-controls/google//modules/regular_service_perimeter"
  version = "~> 6.2.0"

  policy              = google_access_context_manager_access_policy.access_policy.name
  perimeter_name      = var.perimeter_name
  description         = "Perimeter shielding projects"
  resources           = var.protected_project_numbers
  access_levels       = [module.access_level_members.name]
  restricted_services = ["storage.googleapis.com"]
  # ingress_policies    = var.ingress_policies
  shared_resources = {
    all = var.protected_project_numbers
  }
}
