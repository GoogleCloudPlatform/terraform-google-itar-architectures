module "gcloud" {
  source                 = "terraform-google-modules/gcloud/google"
  version                = "~> 3.1"
  platform               = "linux"
  create_cmd_entrypoint  = "${path.module}/scripts/create.sh"
  create_cmd_body        = "${var.gcs_kms_ring_name} ${var.gcs_kms_key_name} ${var.project_id} ${var.location_endpoint} ${var.bucket_name} ${var.cmek_project_id} ${var.lifecycle_file}" 
  destroy_cmd_entrypoint = "${path.module}/scripts/destroy.sh"
  destroy_cmd_body       = "${var.bucket_name} ${var.location_endpoint} ${var.gcs_kms_ring_name} ${var.gcs_kms_key_name} ${var.cmek_project_id} ${var.project_id}"
}
