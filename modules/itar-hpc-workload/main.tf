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


data "google_project" "primary" {
  project_id = var.project_id
}

module "storage_kms" {
  source  = "terraform-google-modules/kms/google"
  version = "2.2.1"

  project_id = var.cmek_project_id
  keyring    = var.gcs_kms_ring_name
  location   = var.gcs_location
  keys       = [var.gcs_kms_key_name]
  purpose    = "ENCRYPT_DECRYPT"
  # if keys can be destroyed by Terraform
  prevent_destroy = var.kms_prevent_destroy
}

# The code is for creating  gcs buckets with locational endpoints
module "gcs_locational_endpoints" {
  source             = "../gcs-locational-endpoints"
  project_id         = var.project_id
  cmek_project_id    = var.cmek_project_id
  location_endpoint  = var.gcs_location
  gcs_kms_ring_name  = module.storage_kms.keyring_name
  gcs_kms_key_name   = keys(module.storage_kms.keys)[0]
  input_bucket_name  = var.input_bucket_name
  output_bucket_name = var.output_bucket_name
  lifecycle_file     = var.bucket_lifecycle_file
}

module "gce_kms" {
  source  = "terraform-google-modules/kms/google"
  version = "2.2.1"

  project_id = var.cmek_project_id
  keyring    = var.gce_keyring_name
  location   = var.region
  # if keys can be destroyed by Terraform
  prevent_destroy = var.kms_prevent_destroy
}

# Create a VPC to deploy the HPC ready vm
module "hpc_vpc" {
  source          = "terraform-google-modules/network/google"
  version         = "~> 6.0"
  project_id      = var.project_id
  network_name    = var.hpc_network_name
  shared_vpc_host = false
  subnets         = var.hpc_subnets
}


#Create a NAT gateway 
module "hpc_nat_gateway" {
  source  = "terraform-google-modules/cloud-router/google"
  version = "~> 4.0"
  project = var.project_id
  name    = var.hpc_router_name
  network = module.hpc_vpc.network_self_link
  region  = var.hpc_router_region

  nats = [{
    name                               = var.hpc_nat_name
    source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
  }]
}

#Create a HPC ready VM
module "hpc_vm" {
  source               = "../compute-engine-hpc"
  project_id           = var.project_id
  cmek_project_id      = var.cmek_project_id
  instance_prefix      = var.hpc_instance_prefix
  region               = var.region
  tags                 = var.hpc_tags
  network              = module.hpc_vpc.network_self_link
  subnetwork           = module.hpc_vpc.subnets_names[0]
  disk_size_gb         = var.hpc_disk_size
  machine_type         = var.hpc_machine_type
  num_instances        = var.hpc_num_instances
  instance_name        = var.hpc_instance_name
  source_image_family  = var.hpc_source_image
  source_image_project = var.hpc_source_image_project
  deletion_protection  = var.hpc_deletion_protection
  sa_prefix            = var.sa_prefix
  zone                 = var.hpc_zone
  use_existing_keyring = var.hpc_use_existing_keyring
  keyring_name         = var.hpc_use_existing_keyring ? var.hpc_keyring_name : ""
  key_rotation_period  = var.key_rotation_period
  depends_on           = [module.hpc_nat_gateway]
}

# Deploy Confidential Postgress SQL VM
module "compute_engine_database_primary" {
  source               = "../compute-engine-db"
  project_id           = var.project_id
  cmek_project_id      = var.cmek_project_id
  instance_prefix      = var.db_instance_prefix
  region               = var.region
  tags                 = var.db_tags
  disk_size_gb         = var.db_disk_size_gb
  machine_type         = var.db_machine_type
  num_instances        = var.db_num_instances
  instance_name        = var.db_instance_name
  source_image         = var.db_source_image
  source_image_project = var.db_source_image_project
  deletion_protection  = var.db_deletion_protection
  sa_prefix            = var.sa_prefix
  zone                 = var.db_zone
  network              = module.hpc_vpc.network_self_link
  subnetwork           = module.hpc_vpc.subnets_names[1]
  use_existing_keyring = var.db_use_existing_keyring
  keyring_name         = var.db_use_existing_keyring ? var.db_keyring_name : ""
  key_rotation_period  = var.key_rotation_period
  depends_on           = [module.hpc_nat_gateway]
}

#Enable firewall rules that allow users to access HPC VM and Postgress
module "firewall_allow_db" {
  source  = "terraform-google-modules/network/google//modules/firewall-rules"
  version = "~> 6.0"

  project_id   = var.project_id
  network_name = module.hpc_vpc.network_self_link
  rules = [
    {
      name                    = "hpc-firewall01"
      description             = "hpc firewall rules"
      direction               = "INGRESS"
      source_tags             = ["hpc-vm"]
      target_tags             = ["db-vm"]
      source_service_accounts = null
      target_service_accounts = null
      priority                = null
      ranges                  = null
      deny                    = []
      allow = [{
        protocol = "tcp"
        ports    = ["5432"]
      }]
      log_config = null
  }]
  depends_on = [
    module.compute_engine_database_primary
  ]
}

#Create a DMZ VPC to deploy compute engine for accessing HPC VM
module "dmz_vpc" {
  source          = "terraform-google-modules/network/google"
  version         = "~> 6.0"
  project_id      = var.project_id
  network_name    = var.dmz_network_name
  shared_vpc_host = false
  subnets         = var.dmz_subnets
}

module "dmz_nat_gateway" {
  source  = "terraform-google-modules/cloud-router/google"
  version = "~> 4.0"
  project = var.project_id
  name    = var.dmz_router_name
  network = module.dmz_vpc.network_self_link
  region  = var.dmz_router_region

  nats = [{
    name                               = var.dmz_nat_name
    source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
  }]
}

#Create a confidential compute engine in DMZ network
module "compute_engine_dmz" {
  source               = "../compute-engine-dmz"
  project_id           = var.project_id
  cmek_project_id      = var.cmek_project_id
  instance_prefix      = var.dmz_instance_prefix
  region               = var.region
  tags                 = var.dmz_tags
  disk_size_gb         = var.dmz_disk_size_gb
  machine_type         = var.dmz_machine_type
  num_instances        = var.dmz_num_instances
  instance_name        = var.dmz_instance_name
  source_image         = var.dmz_source_image
  source_image_project = var.dmz_source_image_project
  deletion_protection  = var.dmz_deletion_protection
  sa_prefix            = var.sa_prefix
  zone                 = var.dmz_zone
  network              = module.dmz_vpc.network_self_link
  subnetwork           = module.dmz_vpc.subnets_names[0]
  use_existing_keyring = var.dmz_use_existing_keyring
  keyring_name         = var.dmz_use_existing_keyring ? var.dmz_keyring_name : ""
  key_rotation_period  = var.key_rotation_period
  depends_on           = [module.dmz_nat_gateway]
}

#Peer HPC VPC and DMZ VPC
module "dmz_hpc_peering" {
  source  = "terraform-google-modules/network/google//modules/network-peering"
  version = "~> 6.0"

  local_network = module.dmz_vpc.network_self_link
  peer_network  = module.hpc_vpc.network_self_link
}

module "firewall_allow_dmz" {
  source  = "terraform-google-modules/network/google//modules/firewall-rules"
  version = "~> 6.0"

  project_id   = var.project_id
  network_name = module.hpc_vpc.network_self_link
  rules = [
    {
      name                    = "dmz-firewall01"
      description             = "dmz firewall rules"
      direction               = "INGRESS"
      ranges                  = [module.dmz_vpc.subnets_ips[0]]
      destination_ranges      = null
      source_tags             = null
      target_tags             = null
      source_service_accounts = null
      target_service_accounts = null
      priority                = null
      allow = [{
        protocol = "tcp"
        ports    = ["22"]
      }]
      deny       = []
      log_config = null
  }]
  depends_on = [
    module.dmz_hpc_peering
  ]
}

#Ensure Storage apis are secured with Private service connect
module "vpc_servicecontrol" {
  source                    = "../vpc-sc"
  parent_id                 = var.parent_id
  policy_name               = var.policy_name
  protected_project_numbers = [data.google_project.primary.number]
  scopes                    = ["projects/${data.google_project.primary.number}"]
  members                   = concat(var.members, ["serviceAccount:${data.google_project.primary.number}-compute@developer.gserviceaccount.com"])
  access_level_name         = var.access_level_name
  perimeter_name            = var.perimeter_name
  # ingress_policies = var.vpc_sc_ingress_policies
  depends_on = [module.dmz_hpc_peering]
}

#Create private service connect so HPC cluster can connect with input and output buckets
module "private_service_connect" {
  source                       = "../privateserviceconnect"
  project_id                   = var.project_id
  network_self_link            = module.hpc_vpc.network_self_link
  private_service_connect_name = var.private_service_connect_name
  private_service_connect_ip   = var.private_service_connect_ip
  forwarding_rule_name         = var.private_service_forwarding_rule
  depends_on                   = [module.hpc_vpc, module.vpc_servicecontrol]
}

#Configure  IAP firewalls to access the compute engine
module "iap" {
  source        = "../iap-tunnel"
  project_id    = var.project_id
  name          = var.iap_name
  network       = module.dmz_vpc.network_self_link
  instance_name = module.compute_engine_dmz.instances_self_links[0]
  zone          = var.iap_zone
  members       = var.iap_members
  depends_on    = [module.private_service_connect]
}

# The deny-compute-unsecur-api rule make sure that ITAR customers cannot suspend/resume instances and cannot use GetSerialPortOutput and GetScreenshot APIs
resource "google_iam_deny_policy" "token_deny" {
  provider = google-beta
  name     = var.deny_policy_name
  parent   = urlencode("cloudresourcemanager.googleapis.com/projects/${var.project_id}")
  rules {
    description = "deny-token-creator-rule"
    deny_rule {
      denied_principals  = ["principalSet://goog/public:all"]
      denied_permissions = ["iam.googleapis.com/serviceAccounts.getAccessToken", "iam.googleapis.com/serviceAccounts.getOpenIdToken", "iam.googleapis.com/serviceAccounts.implicitDelegation", "iam.googleapis.com/serviceAccounts.signBlob", "iam.googleapis.com/serviceAccounts.signJwt"]
    }
  }
  rules {
    description = "deny_compute_unsecure_api"
    deny_rule {
      denied_principals  = ["principalSet://goog/public:all"]
      denied_permissions = ["compute.googleapis.com/instances.suspend", "compute.googleapis.com/instances.resume", "compute.googleapis.com/instances.getSerialPortOutput", "compute.googleapis.com/instances.getScreenshot"]
    }
  }
}
