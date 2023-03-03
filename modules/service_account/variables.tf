variable "project_id" {
  type        = string
  description = "The ID of the project in which the service account will be created."
}

variable "account_id" {
  type        = string
  description = "The service account id."
}

variable "display_name" {
  type        = string
  description = "The service account display name."
  default     = ""
}

variable "description" {
  type        = string
  description = "The service account description."
  default     = ""
}
