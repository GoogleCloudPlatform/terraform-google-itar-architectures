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

# Defining local variable forproject  = var.project_id different type of keys, controls used here in this module
locals {
  keys_by_name = zipmap(var.keys, var.prevent_destroy ? slice(google_kms_crypto_key.key[*].id, 0, length(var.keys)) : slice(google_kms_crypto_key.key_ephemeral[*].id, 0, length(var.keys)))
}

# Data block to use existing key ring
data "google_kms_key_ring" "existing_key_ring" {
  count = var.use_existing_keyring ? 1 : 0
  name  = var.keyring
  #project  = var.project_id
  project  = var.cmek_project_id
  location = var.location
}

#This block will create a new key ring
resource "google_kms_key_ring" "key_ring" {
  count = var.use_existing_keyring ? 0 : 1
  name  = var.keyring
  #project  = var.project_id
  project  = var.cmek_project_id
  location = var.location
}

# Creates random string suffix for key so unique keys will be generated
resource "random_string" "crypto_key_sufix" {
  length    = 8
  min_lower = 8
}

# This creates a logical key which will be used for cryptographic operations.This also gives funtionality of lifecycle hooks and prevent accidental destruction of keys. This also sets the algorithm used for key and rotation period
resource "google_kms_crypto_key" "key" {
  count           = var.prevent_destroy ? length(var.keys) : 0
  name            = "${var.keys[count.index]}-${random_string.crypto_key_sufix.result}"
  key_ring        = var.use_existing_keyring ? data.google_kms_key_ring.existing_key_ring[0].id : google_kms_key_ring.key_ring[0].id
  rotation_period = var.key_rotation_period
  depends_on      = [google_kms_key_ring.key_ring]

  lifecycle {
    prevent_destroy = false
  }

  version_template {
    algorithm        = var.key_algorithm
    protection_level = var.key_protection_level
  }

  labels = var.labels
}

# This creates a logical ephemeral key which will be used for cryptographic operations.This also gives funtionality of lifecycle hooks and prevent accidental destruction of keys. This also sets the algorithm used for key and rotation period
resource "google_kms_crypto_key" "key_ephemeral" {
  count           = var.prevent_destroy ? 0 : length(var.keys)
  name            = "${var.keys[count.index]}-${random_string.crypto_key_sufix.result}"
  key_ring        = var.use_existing_keyring ? data.google_kms_key_ring.existing_key_ring[0].id : google_kms_key_ring.key_ring[0].id
  rotation_period = var.key_rotation_period

  lifecycle {
    prevent_destroy = false
  }

  version_template {
    algorithm        = var.key_algorithm
    protection_level = var.key_protection_level
  }

  labels = var.labels
}

# This will update the IAM policy to grant a role of owner of key to only selected users and ensure not allUsers will have this access
resource "google_kms_crypto_key_iam_binding" "owners" {
  for_each      = toset(var.set_owners_for)
  role          = "roles/owner"
  crypto_key_id = local.keys_by_name[each.value]
  members       = var.owners
}

# This will update the IAM policy to grant a role of Key decrypter of key to only selected users and ensure not allUsers will have this access
resource "google_kms_crypto_key_iam_binding" "decrypters" {
  for_each      = toset(var.set_decrypters_for)
  role          = "roles/cloudkms.cryptoKeyDecrypter"
  crypto_key_id = local.keys_by_name[each.value]
  members       = var.decrypters
}

# This will update the IAM policy to grant a role of Key encrypter of key to only selected users and ensure not allUsers will have this access
resource "google_kms_crypto_key_iam_binding" "encrypters" {
  for_each      = toset(var.set_encrypters_for)
  role          = "roles/cloudkms.cryptoKeyEncrypter"
  crypto_key_id = local.keys_by_name[each.value]
  members       = var.encrypters
}
