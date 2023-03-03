variable "project_id" {
  description = "The project ID to host the network in"
  type        = string
}

variable "cmek_project_id" {
  type        = string
  description = "CMEK project id."
}

variable "region" {
  description = "The name of the dmz VPC network being created"
  type        = string
  default     = "us-central1"
}

# variable "use_existing_keyring" {
#   description = "Whether to use existing keyring or not"
#   type        = string
# }

variable "key_rotation_period" {
  description = "Rotation period of keyring"
  type        = string
  default     = "7776000s"
}

variable "key_ring_location" {
  description = "Location of the keyring"
  type        = string
  default     = "us-central1"
}

//Network variables

variable "hpc_network_name" {
  description = "The name of the hpc cluster VPC network being created"
  type        = string
}

variable "dmz_network_name" {
  description = "The name of the hpc cluster VPC network being created"
  type        = string
}

variable "hpc_subnets" {
  type        = list(map(string))
  description = "The list of subnets being created"
}

variable "dmz_subnets" {
  type        = list(map(string))
  description = "The list of subnets being created"
}



//Firewall Rules

variable "hpc_firewall_rule" {
  description = "List of custom rule definitions (refer to variables file for syntax)."
  default     = []
  type = list(object({
    name                    = string
    description             = string
    direction               = string
    priority                = number
    ranges                  = list(string)
    source_tags             = list(string)
    source_service_accounts = list(string)
    target_tags             = list(string)
    target_service_accounts = list(string)
    allow = list(object({
      protocol = string
      ports    = list(string)
    }))
    deny = list(object({
      protocol = string
      ports    = list(string)
    }))
    log_config = object({
      metadata = string
    })
  }))
}
/*
variable "dmz_firewall_rule" {
  description = "List of custom rule definitions (refer to variables file for syntax)."
  default     = []
  type = list(object({
    name                    = string
    description             = string
    direction               = string
    priority                = number
    ranges                  = list(string)
    source_tags             = list(string)
    source_service_accounts = list(string)
    target_tags             = list(string)
    target_service_accounts = list(string)
    allow = list(object({
      protocol = string
      ports    = list(string)
    }))
    deny = list(object({
      protocol = string
      ports    = list(string)
    }))
    log_config = object({
      metadata = string
    })
  }))
}
*/

#HPC variables

variable "hpc_instance_prefix" {
  description = "Instance"
  type        = string
  default     = "itar"
}

variable "hpc_tags" {
  description = "Tags for HPC"
  type        = list(string)
}

variable "hpc_disk_size" {
  description = "HPC disk size"
  type        = string
  default     = "50"
}

variable "hpc_machine_type" {
  description = "HPC machine type"
  type        = string
  default     = "c2-standard-4"
}

variable "hpc_num_instances" {
  description = "HPC number of instances"
  type        = string
  default     = "1"
}

variable "hpc_instance_name" {
  description = "HPC instance name"
  type        = string
}

variable "hpc_source_image" {
  description = "HPC Source disk image."
  type        = string
  default     = "hpc-centos-7"
}

variable "hpc_source_image_project" {
  description = "HPC Source disk image project."
  type        = string
  default     = "cloud-hpc-image-public"
}

variable "hpc_deletion_protection" {
  description = "Enable deletion protection on this instance. Note: you must disable deletion protection before removing the resource, or the instance cannot be deleted and the Terraform run will not complete successfully."
  type        = bool
}



#IAP 

variable "iap_name" {
  description = "Name of IAP"
  type        = string
}

variable "iap_zone" {
  description = "IAP zone"
  type        = string
  default     = null
}

variable "iap_members" {
  description = "IAP members"
  type        = list(string)
}

#Private Service Connect

variable "private_service_connect_name" {
  description = "Name of private service connect"
  type        = string
}

variable "private_service_connect_ip" {
  description = "IP for private service connect"
  type        = string
}

variable "private_service_forwarding_rule" {
  description = "Name of private service connect forwarding rule"
  type        = string
}


#Compute Engine

variable "db_instance_prefix" {
  description = "value"
  type        = string
  default     = "itar"
}

variable "db_instance_name" {
  description = "HPC instance name"
  type        = string
}

variable "db_tags" {
  description = "Tags for db instance"
  type        = list(string)
}
variable "db_disk_size_gb" {
  description = "Boot disk size in GB"
  type        = string
  default     = "50"
}

variable "db_disk_type" {
  description = "Boot disk type, can be either pd-ssd or pd-standard"
  type        = string
  default     = "pd-standard"
}

variable "db_machine_type" {
  description = "Machine type to create. Note that the instance image must support Confidential VMs"
  type        = string
}

variable "db_deletion_protection" {
  description = "Enable deletion protection on this instance. Note: you must disable deletion protection before removing the resource, or the instance cannot be deleted and the Terraform run will not complete successfully."
  type        = bool
}

variable "roles_list" {
  description = "roles list for the service account"
  type        = list(string)
  default     = []
}

variable "dmz_instance_prefix" {
  description = "value"
  type        = string
  default     = "itar"
}

variable "dmz_instance_name" {
  description = "HPC instance name"
  type        = string
}

variable "dmz_tags" {
  description = "Tags for db instance"
  type        = list(string)
}

variable "dmz_disk_size_gb" {
  description = "Boot disk size in GB"
  type        = string
  default     = "50"
}

variable "dmz_disk_type" {
  description = "Boot disk type, can be either pd-ssd or pd-standard"
  type        = string
  default     = "pd-standard"
}

variable "dmz_machine_type" {
  description = "Machine type to create. Note that the instance image must support Confidential VMs"
  type        = string
}

variable "db_zone" {
  description = "Zone of db instnace"
  type        = string
  default     = null
}

variable "db_num_instances" {
  description = "Number of instances to create."
  type        = string
  default     = "1"
}

variable "db_source_image" {
  description = "Source disk image. Note that the instance image must support Confidential VMs."
  type        = string
}

variable "db_source_image_project" {
  description = "Source disk image project. Note that the instance image must support Confidential VMs."
  type        = string
}

variable "dmz_zone" {
  description = "Zone of db instnace"
  type        = string
  default     = null
}

variable "dmz_num_instances" {
  description = "Number of instances to create."
  type        = string
  default     = "1"
}

variable "dmz_source_image" {
  description = "Source disk image. Note that the instance image must support Confidential VMs."
  type        = string
}

variable "dmz_source_image_project" {
  description = "Source disk image project. Note that the instance image must support Confidential VMs."
  type        = string
}

variable "dmz_deletion_protection" {
  description = "Enable deletion protection on this instance. Note: you must disable deletion protection before removing the resource, or the instance cannot be deleted and the Terraform run will not complete successfully."
  type        = bool
}

variable "metadata" {
  description = "Metadata provided as a map"
  type        = map(string)
  default = {
    serial-port-enable = false
  }
}

variable "sa_prefix" {
  description = "Name prefix for the service account"
  type        = string
  default     = "itar"
}

variable "access_config" {
  description = "Access configurations, i.e. IPs via which the VM instance can be accessed via the Internet. The networking tier used for configuring this instance. This field can take the following values: PREMIUM or STANDARD."
  type = list(object({
    nat_ip       = string
    network_tier = string
  }))
  default = []
}

variable "hpc_zone" {
  type        = string
  description = "Zone where the instances should be created. If not specified, instances will be spread across available zones in the region."
  default     = null
}

#VPC SC Variables

variable "parent_id" {
  description = "The parent of this AccessPolicy in the Cloud Resource Hierarchy. As of now, only organization (org id) are accepted as parent."
  type        = string
}

variable "policy_name" {
  description = "The policy's name."
  type        = string
}

variable "protected_project_ids" {
  description = "Project id and number of the project INSIDE the regular service perimeter. This map variable expects an \"id\" for the project id and \"number\" key for the project number."
  type        = object({ id = string, number = number })
}

variable "perimeter_name" {
  description = "Perimeter name of the Access Policy.."
  type        = string
}

variable "members" {
  description = "An allowed list of members (users, service accounts). The signed-in identity originating the request must be a part of one of the provided members. If not specified, a request may come from any user (logged in/not logged in, etc.). Formats: user:{emailid}, serviceAccount:{emailid}"
  type        = list(string)
}

variable "scopes" {
  description = "Define the scope as project (list)  ex: projects/projectnumber"
  type        = list(string)
}

variable "access_level_name" {
  description = "Access level name of the Access Policy."
  type        = string
}

//IAM deny 

variable "deny_policy_name" {
  description = "Name of IAM deny policy"
  type        = string
}

#HPC NAT Variables

variable "hpc_router_name" {
  description = "Name of the router"
  type        = string
  default     = "hpc-itar-router"

}

variable "hpc_router_region" {
  description = "Name of the router region"
  type        = string
  default     = "us-central1"

}

variable "hpc_nat_name" {
  description = "Name of the name"
  type        = string
  default     = "hpc-itar-nat"

}

# DMZ NAT variables

variable "dmz_router_name" {
  description = "Name of the router"
  type        = string
  default     = "dmz-itar-router"
}

variable "dmz_router_region" {
  description = "Name of the router region"
  type        = string
  default     = "us-central1"
}

variable "dmz_nat_name" {
  description = "Name of the name"
  type        = string
  default     = "dmz-itar-nat"
}

# GCS Locational endpoints

variable "gcs_location" {
  description = "Location endpoint (region) for creating bucket"
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

variable "bucket_lifecycle_file" {
  description = "File path for GCS lifecycle policy (JSON format)"
  type = string
}

# KMS Varaibles all modules

# variable "ipbkt_use_existing_keyring" {
#   description = "Whether to use existing keyring or not"
#   type        = string
# }

# variable "opbkt_use_existing_keyring" {
#   description = "Whether to use existing keyring or not"
#   type        = string
# }

variable "hpc_use_existing_keyring" {
  description = "Whether to use existing keyring or not"
  type        = string
}

variable "db_use_existing_keyring" {
  description = "Whether to use existing keyring or not"
  type        = string
}

variable "dmz_use_existing_keyring" {
  description = "Whether to use existing keyring or not"
  type        = string
}

# variable "ipbkt_keyring_name" {
#   description = "Name of input bucket keyring"
#   type        = string
# }

# variable "opbkt_keyring_name" {
#   description = "Name of output bucket keyring"
#   type        = string
# }

# variable "hpc_keyring_name" {
#   description = "Name of keyring"
#   type        = string
# }

# variable "db_keyring_name" {
#   description = "Name of keyring"
#   type        = string
# }

# variable "dmz_keyring_name" {
#   description = "Name of keyring"
#   type        = string
# }

variable "gce_keyring_name" {
  description = "Name of keyring to use for GCE instances"
  type        = string
}

variable "kms_prevent_destroy" {
  description = "Set to true to prevent deletion of KMS keys upon running Terraform destroy"
  type        = bool
  default     = true
}
