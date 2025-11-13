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

module "gcloud" {
  source                 = "terraform-google-modules/gcloud/google"
  version                = "~> 4.0"
  platform               = "linux"
  create_cmd_entrypoint  = "${path.module}/scripts/create.sh"
  create_cmd_body        = "${var.gcs_kms_ring_name} ${var.gcs_kms_key_name} ${var.project_id} ${var.location_endpoint} ${var.input_bucket_name} ${var.output_bucket_name} ${var.cmek_project_id} ${var.lifecycle_file}"
  destroy_cmd_entrypoint = "${path.module}/scripts/destroy.sh"
  destroy_cmd_body       = "${var.input_bucket_name} ${var.output_bucket_name} ${var.location_endpoint} ${var.gcs_kms_ring_name} ${var.gcs_kms_key_name} ${var.cmek_project_id} ${var.project_id}"
}
