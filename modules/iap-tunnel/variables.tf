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
  type = string
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



