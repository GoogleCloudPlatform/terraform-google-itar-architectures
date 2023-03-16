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
}

variable "cmek_project_id" {
  description = "Asuured workloads project id."
  type        = string
}

variable "location_endpoint" {
  description = "Location endpoint for creating bucket"
  type        = string
}

variable "gcs_kms_ring_name" {
  description = "KMS key ring name"
  type        = string
}


variable "gcs_kms_key_name" {
  description = "KMS key name"
  type        = string
}

variable "input_bucket_name" {
  description = "Name of the input bucket"
  type        = string
}

variable "output_bucket_name" {
  description = "Name of the output bucket"
  type        = string
}

variable "lifecycle_file" {
  description = "File with GCS lifecycle rules"
  type        = string
}
