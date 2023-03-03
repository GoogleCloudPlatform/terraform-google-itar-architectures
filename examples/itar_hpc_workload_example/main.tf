/**
 * Copyright 2021 Google LLC
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

module "itar_hpc_workload" {
  source = "../../modules/itar-hpc-workload"

  project_id      = var.project_id
  cmek_project_id = var.assured_workload_cmek_project_id

  # HPC VPC Varaibles
  hpc_network_name = "hpc-vpc"
  hpc_subnets = [
    {
      subnet_name           = "hpc-subnet-01"
      subnet_ip             = "10.10.10.0/24"
      subnet_region         = "us-central1"
      subnet_private_access = "true"
      subnet_flow_logs      = "true"
    },
    {
      subnet_name           = "hpc-subnet-02"
      subnet_ip             = "10.10.20.0/24"
      subnet_region         = "us-central1"
      subnet_private_access = "true"
      subnet_flow_logs      = "true"
    },
  ]

  #DMZ VPC Variables
  dmz_network_name = "dmz-vpc"
  dmz_subnets = [
    {
      subnet_name           = "dmz-subnet-01"
      subnet_ip             = "10.10.30.0/24"
      subnet_region         = "us-central1"
      subnet_private_access = "true"
      subnet_flow_logs      = "true"
    }
  ]

  region                   = "us-central1"
  db_instance_name         = "postgres-vm"
  db_disk_size_gb          = "50"
  db_machine_type          = "n2d-standard-4"
  db_num_instances         = "1"
  db_source_image          = "ubuntu-2004-lts"
  db_source_image_project  = "ubuntu-os-cloud"
  db_zone                  = "us-central1-b"
  db_deletion_protection   = false
  dmz_instance_prefix      = "itar"
  dmz_instance_name        = "dmz-vm"
  dmz_disk_size_gb         = "50"
  dmz_tags                 = ["dmz-vm"]
  dmz_machine_type         = "n2d-standard-4"
  dmz_num_instances        = "1"
  dmz_source_image         = "ubuntu-2004-lts"
  dmz_source_image_project = "ubuntu-os-cloud"
  dmz_zone                 = "us-central1-b"
  dmz_deletion_protection  = false
  hpc_zone                 = null
  hpc_instance_prefix      = "itar-hpc-vm-template-"
  hpc_tags                 = ["hpc-vm"]
  hpc_disk_size            = "50"
  hpc_machine_type         = "c2-standard-4"
  hpc_num_instances        = "2"
  hpc_instance_name        = "itar-hpc-vm"
  hpc_source_image         = "hpc-centos-7"
  hpc_source_image_project = "cloud-hpc-image-public"
  hpc_deletion_protection  = false
  sa_prefix                = "itar"
  iap_name                 = "iap-firewall"
  iap_zone                 = "us-central1-b"
  iap_members              = ["serviceAccount:169752266853-compute@developer.gserviceaccount.com", "user:mmasooduddin@assuredworkloadsfortesting.com"] // keep in this format change email addresses
  # bucket_prefix            = "itar"
  db_instance_prefix       = "itar-postgress-template-"
  db_tags                  = ["db-vm"]
  key_rotation_period = "7776000s"
  key_ring_location   = "us-central1"
  parent_id           = "468180499708"
  policy_name         = "policyvpcsc03"
  protected_project_ids = {
    id     = "itar-use-case"
    number = 169752266853
  }
  perimeter_name                  = "itarperimeter"
  access_level_name               = "access_members"
  members                         = ["user:mmasooduddin@assuredworkloadsfortesting.com", "serviceAccount:169752266853-compute@developer.gserviceaccount.com"]
  scopes                          = ["projects/169752266853"]
  private_service_connect_name    = "psconnect"
  private_service_connect_ip      = "10.0.1.8"
  private_service_forwarding_rule = "forwardingrulepsc01"
  deny_policy_name                = "denyrule2"

  hpc_router_name   = "hpc-itar-router"
  hpc_router_region = "us-central1"
  hpc_nat_name      = "hpc-itar-nat"

  dmz_router_name   = "dmz-itar-router"
  dmz_router_region = "us-central1"
  dmz_nat_name      = "dmz-itar-nat"

  # KMS variables

  # ipbkt_use_existing_keyring = false
  # ipbkt_keyring_name         = "kms1-key-ring"
  # opbkt_use_existing_keyring = true
  # opbkt_keyring_name         = "kms1-key-ring"
  hpc_use_existing_keyring   = true
  # hpc_keyring_name           = "kms1-key-ring"
  db_use_existing_keyring    = true
  # db_keyring_name            = "kms1-key-ring"
  dmz_use_existing_keyring   = true
  # dmz_keyring_name           = "kms1-key-ring"
  gce_keyring_name           = "kms1-key-ring"

  # GCS locational endpoint varaibles

  gcs_location          = "us-central1"
  gcs_kms_ring_name     = "gcsendpointkr1"
  gcs_kms_key_name      = "gcskey2"
  input_bucket_name     = "hpcinputbucket-ty3"
  output_bucket_name    = "hpcinputbucket-ty4"
  bucket_lifecycle_file = "${path.module}/lifecycle.json"

  kms_prevent_destroy = false
}
