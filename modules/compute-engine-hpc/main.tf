resource "random_id" "sa_sufix" {
  byte_length = 8
}

data "google_service_account" "existing_account" {
  count      = var.compute_service_account == "" ? 0 : 1
  account_id = var.compute_service_account
  project    = var.project_id
}

module "vm_service_account" {
  count        = var.compute_service_account == "" ? 1 : 0
  source       = "../service_account"
  account_id   = "sa-${var.sa_prefix}${random_id.sa_sufix.dec}"
  display_name = "vm_service_account"
  description  = "service account for vm"
  project_id   = var.project_id
}

resource "google_compute_instance_iam_member" "instance_iam" {
  for_each      = toset(var.roles_list)
  project       = var.project_id
  instance_name = module.compute_instance.instances_self_links[0]
  role          = each.key
  zone          = var.zone
  member        = var.compute_service_account == "" ? "serviceAccount:${module.vm_service_account[0].email}" : "serviceAccount:${data.google_service_account.existing_account[0].email}"
}

resource "google_project_iam_member" "project" {
  for_each = toset(var.srv_roles_list)
  project  = var.project_id
  role     = each.key
  member   = var.compute_service_account == "" ? "serviceAccount:${module.vm_service_account[0].email}" : "serviceAccount:${data.google_service_account.existing_account[0].email}"
}

data "google_project" "compute_project" {
  project_id = var.project_id
}

module "kms" {
  count  = var.create_key ? 1 : 0
  source = "../kms/"
  #project_id           = var.project_id
  cmek_project_id      = var.cmek_project_id
  use_existing_keyring = var.use_existing_keyring
  keyring              = var.keyring_name
  location             = var.region
  keys                 = [var.key_name]
  key_rotation_period  = var.key_rotation_period
  encrypters           = ["serviceAccount:service-${data.google_project.compute_project.number}@compute-system.iam.gserviceaccount.com"]
  set_encrypters_for   = [var.key_name]
  decrypters           = ["serviceAccount:service-${data.google_project.compute_project.number}@compute-system.iam.gserviceaccount.com"]
  set_decrypters_for   = [var.key_name]
}

resource "google_kms_crypto_key_iam_binding" "crypto_key" {
  count         = var.create_key ? 0 : 1
  crypto_key_id = var.disk_encryption_key
  role          = "roles/cloudkms.cryptoKeyEncrypterDecrypter"
  members       = ["serviceAccount:service-${data.google_project.compute_project.number}@compute-system.iam.gserviceaccount.com"]
}

module "instance_template" {
  source             = "terraform-google-modules/vm/google//modules/instance_template"
  name_prefix        = var.instance_prefix
  labels             = var.labels
  project_id         = var.project_id
  region             = var.region
  network            = var.network
  subnetwork         = var.subnetwork
  subnetwork_project = var.project_id
  service_account = var.compute_service_account == "" ? ({
    email  = module.vm_service_account[0].email
    scopes = ["compute-rw", "storage-rw"]
    }) : ({
    email  = data.google_service_account.existing_account[0].email
    scopes = ["compute-rw", "storage-rw"]
  })
  access_config       = [{ nat_ip = null, network_tier = null }]
  can_ip_forward      = false
  disk_encryption_key = var.create_key ? module.kms[0].keys[var.key_name] : var.disk_encryption_key
  disk_size_gb        = var.disk_size_gb
  disk_type           = var.disk_type
  machine_type        = var.machine_type
  enable_shielded_vm  = true
  shielded_instance_config = ({
    enable_secure_boot          = true
    enable_vtpm                 = true
    enable_integrity_monitoring = true
  })
  #    enable_confidential_vm       = true
  enable_nested_virtualization = false
  source_image_family          = var.source_image_family
  source_image_project         = var.source_image_project
  #    guestOsFeatures = ({type = SEV_CAPABLE})
  startup_script      = file("${path.module}/scripts/install.sh")
  metadata            = var.metadata
  on_host_maintenance = "TERMINATE"
  tags                = var.tags
  automatic_restart   = true
  depends_on          = [module.kms]
}

module "compute_instance" {
  source              = "terraform-google-modules/vm/google//modules/compute_instance"
  instance_template   = module.instance_template.self_link
  hostname            = var.instance_name
  add_hostname_suffix = true
  deletion_protection = var.deletion_protection
  region              = var.region
  num_instances       = var.num_instances
  network             = var.network
  subnetwork          = var.subnetwork
  subnetwork_project  = var.project_id
  zone                = var.zone
  access_config       = var.access_config
  # resource_policies   = [google_compute_resource_policy.vm_resource_policy.self_link]
  depends_on = [module.instance_template]
}
