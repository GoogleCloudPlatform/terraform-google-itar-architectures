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

variable "parent_id" {
  description = "The parent of this AccessPolicy in the Cloud Resource Hierarchy. As of now, only organization are accepted as parent."
  type        = string
}

variable "scopes" {
  description = "Define the scope as project (list)  ex: projects/projectnumber"
  type        = list(string)
}

variable "policy_name" {
  description = "The policy's name."
  type        = string
}

variable "protected_project_numbers" {
  description = "Project id and number of the project INSIDE the regular service perimeter. This map variable expects an \"id\" for the project id and \"number\" key for the project number."
  type        = list(string)
}

variable "members" {
  description = "An allowed list of members (users, service accounts). The signed-in identity originating the request must be a part of one of the provided members. If not specified, a request may come from any user (logged in/not logged in, etc.). Formats: user:{emailid}, serviceAccount:{emailid}"
  type        = list(string)
}

variable "access_level_name" {
  description = "Access level name of the Access Policy."
  type        = string
}

variable "perimeter_name" {
  description = "Perimeter name of the Access Policy.."
  type        = string
}

# variable "ingress_policies" {
#   description = "Ingress policices for VPC-SC perimeter"
#   type        = list(object({
#     from = any
#     to   = any
#   }))
#   default = []
# }
