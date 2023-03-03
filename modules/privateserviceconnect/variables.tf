variable "project_id" {
  description = "Project ID for Private Service Connect."
  type        = string
}

variable "network_self_link" {
  description = "Network self link for Private Service Connect."
  type        = string
}

variable "dns_code" {
  description = "Code to identify DNS resources in the form of `{dns_code}-{dns_type}`"
  type        = string
  default     = "dzcode"
}

variable "private_service_connect_name" {
  description = "Private Service Connect endpoint name. Defaults to `global-psconnect-ip`"
  type        = string
}

variable "private_service_connect_ip" {
  description = "The internal IP to be used for the private service connect."
  type        = string
}

variable "forwarding_rule_name" {
  description = "Forwarding rule resource name. The forwarding rule name for PSC Google APIs must be an 1-20 characters string with lowercase letters and numbers and must start with a letter. Defaults to `globalrule`"
  type        = string
}

variable "forwarding_rule_target" {
  description = "Target resource to receive the matched traffic. Only `all-apis` and `vpc-sc` are valid."
  type        = string
  default     = "vpc-sc"

  validation {
    condition     = var.forwarding_rule_target == "all-apis" || var.forwarding_rule_target == "vpc-sc"
    error_message = "For forwarding_rule_target only `all-apis` and `vpc-sc` are valid."
  }
}
