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

variable "project_id" {
  description = "Asuured workloads project id."
  type        = string
  default     = "itar-use-case"
}

variable "cmek_project_id" {
  description = "Asuured workloads project id."
  type        = string
  default     = "itar-cmek"
}

variable "location_endpoint" {
  description = "Location endpoint for creating bucket"
  type        = string
  default     = "us-central1"
}

variable "gcs_kms_ring_name" {
  description = "KMS key ring name"
  type        = string
  default     = "mykeyr12"
}


variable "gcs_kms_key_name" {
  description = "KMS key name"
  type        = string
  default     = "key-u2"
}

variable "input_bucket_name" {
  description = "Name of the input bucket"
  type        = string
  default     = "aw-puybkt-testyt40"
}

variable "output_bucket_name" {
  description = "Name of the output bucket"
  type        = string
  default     = "aw-puybkt-testyt41"
}

variable "lifecycle_file" {
  description = "File with GCS lifecycle rules"
  type        = string
  default     = "aw-puybkt-testyt41"
}
