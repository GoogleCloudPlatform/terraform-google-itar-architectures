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

# This generates random suffix that is intended to create a unique service account name 
resource "random_id" "sa_sufix" {
  byte_length = 8
}

#Data block to use existing service account and ensure that the VM instance is not associated with the default GCP service account
data "google_service_account" "existing_account" {
  count      = var.compute_service_account == "" ? 0 : 1
  account_id = var.compute_service_account
  project    = var.project_id
}


#This module will create a new service account for compute engine database and ensure that your VM instance is not associated with the default GCP service account
# module "vm_service_account" {
#   count        = var.compute_service_account == "" ? 1 : 0
#   source       = "../service_account"
#   account_id   = "sa-${var.sa_prefix}${random_id.sa_sufix.dec}"
#   display_name = "vm_service_account"
#   description  = "service account for vm"
#   project_id   = var.project_id
# }
resource "google_service_account" "service_account" {
  count        = var.compute_service_account == "" ? 1 : 0
  account_id   = "sa-${var.sa_prefix}${random_id.sa_sufix.dec}"
  project      = var.project_id
  display_name = "DB vm_service_account"
  description  = "service account for DB vm"
}

#This Updates the IAM policy to grant a role to a new member. The members to which roles are assigned here are either existing service account or new service account created for Compute Engine DB
resource "google_compute_instance_iam_member" "instance_iam" {
  for_each      = toset(var.roles_list)
  project       = var.project_id
  instance_name = module.compute_instance.instances_self_links[0]
  role          = each.key
  zone          = var.zone
  member        = var.compute_service_account == "" ? google_service_account.service_account[0].member : "serviceAccount:${data.google_service_account.existing_account[0].email}"
}

#Data block for project id
data "google_project" "compute_project" {
  project_id = var.project_id
}

#This module will be used to create keyring, encryption/decryption keys for compute engine db and ensure that the customer encryption keys will be used for encryption of data stored on Google Compute Engine DB disk
module "kms" {
  count  = var.create_key ? 1 : 0
  source = "../kms/"
  #project_id          = var.project_id
  cmek_project_id      = var.cmek_project_id
  use_existing_keyring = var.use_existing_keyring
  keyring              = var.keyring_name
  location             = var.region
  keys                 = [var.key_name]
  key_rotation_period  = var.key_rotation_period
  encrypters           = ["serviceAccount:service-${data.google_project.compute_project.number}@compute-system.iam.gserviceaccount.com"]
  set_encrypters_for   = [var.key_name]
  decrypters           = ["serviceAccount:service-${data.google_project.compute_project.number}@compute-system.iam.gserviceaccount.com"]
  set_decrypters_for   = [var.key_name]
}


#This will create IAM role binding and give encrypter/decrypter role to the compute engine database service account to encrypt/decrypt Google Compute Engine DB disk
resource "google_kms_crypto_key_iam_binding" "crypto_key" {
  count         = var.create_key ? 0 : 1
  crypto_key_id = var.disk_encryption_key
  role          = "roles/cloudkms.cryptoKeyEncrypterDecrypter"
  members       = ["serviceAccount:service-${data.google_project.compute_project.number}@compute-system.iam.gserviceaccount.com"]
}

#This module will create an instance template which will be used to create compute engine DB. This template enables confidential and shielded security on VM, enables/disables nested virtualization, enable/disables IP forwarding and provide other security controls
module "instance_template" {
  source  = "terraform-google-modules/vm/google//modules/instance_template"
  version = "~> 10.1.0"

  project_id  = var.project_id
  name_prefix = var.instance_prefix
  region      = var.region
  service_account = var.compute_service_account == "" ? ({
    email  = google_service_account.service_account[0].email
    scopes = []
    }) : ({
    email  = data.google_service_account.existing_account[0].email
    scopes = []
  })
  can_ip_forward      = false
  disk_encryption_key = var.create_key ? module.kms[0].keys[var.key_name] : var.disk_encryption_key
  disk_size_gb        = var.disk_size_gb
  disk_type           = var.disk_type
  enable_shielded_vm  = true
  shielded_instance_config = ({
    enable_secure_boot          = true
    enable_vtpm                 = true
    enable_integrity_monitoring = true
  })
  enable_confidential_vm       = true
  enable_nested_virtualization = false
  machine_type                 = var.machine_type
  source_image                 = var.source_image
  source_image_project         = var.source_image_project
  startup_script               = file("${path.module}/scripts/install.sh")
  metadata                     = var.metadata
  labels                       = var.labels
  tags                         = var.tags
  network                      = var.network
  subnetwork                   = var.subnetwork
  subnetwork_project           = var.project_id
  depends_on                   = [module.kms]
}


#This module will create the Compute Engine DB virtual machine from instance template and also enables deletion protection functionality on the instance
module "compute_instance" {
  source  = "terraform-google-modules/vm/google//modules/compute_instance"
  version = "~> 10.1.0"

  instance_template   = module.instance_template.self_link
  hostname            = var.instance_name
  add_hostname_suffix = false
  deletion_protection = var.deletion_protection
  region              = var.region
  num_instances       = var.num_instances
  network             = var.network
  subnetwork          = var.subnetwork
  subnetwork_project  = var.project_id
  zone                = var.zone
  access_config       = var.access_config
  depends_on          = [module.kms]
}
