variable "project_id" {
  description = "Asuured workloads project id."
  type        = string
  # default     = "itar-use-case"
}

variable "cmek_project_id" {
  description = "Asuured workloads CMEK project id."
  type        = string
  # default     = "itar-cmek"
}

variable "location_endpoint" {
  description = "Location endpoint for creating bucket"
  type        = string
  # default     = "us-central1"
}

variable "gcs_kms_ring_name" {
  description = "KMS key ring name"
  type        = string
  # default     = "mykeyr12"
}

variable "gcs_kms_key_name" {
  description = "KMS key name"
  type        = string
  # default     = "key-u2"
}

variable "bucket_name" {
  description = "Name of the bucket"
  type        = string
}

variable "lifecycle_file" {
  description = "File path for GCS lifecycle policy (JSON format)"
  type = string
}

# variable "input_bucket_name" {
#   description = "Name of the input bucket"
#   type        = string
#   # default     = "aw-puybkt-testyt40"
# }

# variable "output_bucket_name" {
#   description = "Name of the output bucket"
#   type        = string
#   # default     = "aw-puybkt-testyt41"
# }