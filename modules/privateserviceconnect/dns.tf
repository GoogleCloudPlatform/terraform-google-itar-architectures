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

/******************************************
  Private Google APIs DNS Zone & records.
 *****************************************/
#This module will create a private dns zone, cname and A record which will enable private consumption of managed service across VPC networks using endpoints to connect to the target service. 

module "googleapis" {
  source      = "terraform-google-modules/cloud-dns/google"
  version     = "~> 5.3.0"
  project_id  = var.project_id
  type        = "private"
  name        = "${local.dns_code}apis"
  domain      = "googleapis.com."
  description = "Private DNS zone to configure ${local.googleapis_url}"

  private_visibility_config_networks = [
    var.network_self_link
  ]

  recordsets = [
    {
      name    = "*"
      type    = "CNAME"
      ttl     = 300
      records = [local.googleapis_url]
    },
    {
      name    = local.recordsets_name
      type    = "A"
      ttl     = 300
      records = [var.private_service_connect_ip]
    },
  ]
}
