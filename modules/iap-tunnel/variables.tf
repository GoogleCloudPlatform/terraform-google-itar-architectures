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
  description = "Project ID"
  type        = string
}

variable "name" {
  description = "Name of Firewall rule"
  type        = string
}

variable "network" {
  description = "Network instance is in"
  type        = string
}


variable "instance_name" {
  description = "Names and zones of instances to allow using SSH from IAP"
  type        = string
}


variable "zone" {
  type        = string
  description = "IAP Tunnel instance zone"
}

variable "members" {
  description = "List if IAM resources to allow using the IAP tunnel"
  type        = list(string)
  /*
        Format of string
        default = [
            "group:dev@exampl.com",
            "user:u@example.com"
        ]
    */
}



