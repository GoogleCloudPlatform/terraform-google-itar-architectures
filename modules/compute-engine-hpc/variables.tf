variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "cmek_project_id" {
  type        = string
  description = "CMEK project id."
}

variable "compute_service_account" {
  description = "The Google service account ID."
  type        = string
  default     = ""
}

variable "instance_prefix" {
  description = "Name prefix for the instance template"
  type        = string
}

variable "region" {
  description = "Region where the instance template should be created."
  type        = string
  default     = "us-central1"
}

variable "disk_size_gb" {
  description = "Boot disk size in GB"
  type        = string
}

variable "disk_type" {
  description = "Boot disk type, can be either pd-ssd, local-ssd, or pd-standard"
  type        = string
  default     = "pd-standard"
}

variable "machine_type" {
  description = "Machine type to create. Note that the instance image must support Confidential VMs"
  type        = string
}

variable "roles_list" {
  description = "roles list for the service account"
  type        = list(string)
  default     = ["roles/compute.osAdminLogin"]
}

variable "srv_roles_list" {
  description = "roles list for the service account at project level"
  type        = list(string)
  default     = ["roles/iam.serviceAccountUser", "roles/compute.instanceAdmin.v1", "roles/storage.admin"]
}

variable "tags" {
  description = "Network tags, provided as a list"
  type        = list(string)
  default     = ["hpc"]
}

variable "network" {
  description = "The name or self_link of the network to attach this interface to. Use network attribute for Legacy or Auto subnetted networks and subnetwork for custom subnetted networks."
  type        = string
  default     = "default"
}

variable "subnetwork" {
  description = "The name of the subnetwork to attach this interface to. The subnetwork must exist in the same region this instance will be created in. Either network or subnetwork must be provided."
  type        = string
  default     = null
}

variable "num_instances" {
  description = "Number of instances to create."
  type        = string
}

variable "instance_name" {
  description = "Name of the instance."
  type        = string
}

variable "source_image_family" {
  description = "Source disk image. Note that the instance image must support Confidential VMs."
  type        = string
  default     = "hpc-centos-7"
}

variable "source_image_project" {
  description = "Source disk image project. Note that the instance image must support Confidential VMs."
  type        = string
  default     = "cloud-hpc-image-public"
}

variable "deletion_protection" {
  description = "Enable deletion protection on this instance. Note: you must disable deletion protection before removing the resource, or the instance cannot be deleted and the Terraform run will not complete successfully."
  type        = bool
}

variable "metadata" {
  description = "Metadata provided as a map"
  type        = map(string)
  default = {
    serial-port-enable = false,
    enable-oslogin     = true
  }
}

variable "labels" {
  description = "Labels provided as a map"
  type        = map(string)
  default     = {}
}

variable "sa_prefix" {
  description = "Name prefix for the service account"
  type        = string
}

variable "access_config" {
  description = "Access configurations, i.e. IPs via which the VM instance can be accessed via the Internet. The networking tier used for configuring this instance. This field can take the following values: PREMIUM or STANDARD."
  type = list(object({
    nat_ip       = string
    network_tier = string
  }))
  default = []
}

variable "zone" {
  type        = string
  description = "Zone where the instances should be created. If not specified, instances will be spread across available zones in the region."
}
/*
variable "resource_policy_name" {
  description = "Placement policy for hpc cluster"
  type        = string
}
*/
/******************************************
  KMS
*****************************************/

variable "create_key" {
  description = "If you want to use an create a key"
  type        = bool
  default     = true
}

variable "disk_encryption_key" {
  description = "The self link of the encryption key that is stored in Google Cloud KMS to use to encrypt all the disks on this instance"
  type        = string
  default     = ""
}

variable "use_existing_keyring" {
  description = "If you want to use an existing keyring and don't create a new one -> true"
  type        = bool
}

variable "key_name" {
  description = "Name to be used for KMS Key for CMEK"
  type        = string
  default     = "key"
}

variable "keyring_name" {
  description = "Name to be used for KMS Keyring for CMEK"
  type        = string
}

variable "key_rotation_period" {
  description = "Rotation period in seconds to be used for KMS Key"
  type        = string
}
