# Local variable for forwarding rule target used for private service connect module
locals {
  dns_code        = var.dns_code != "" ? "${var.dns_code}-" : ""
  googleapis_url  = var.forwarding_rule_target == "vpc-sc" ? "restricted.googleapis.com." : "private.googleapis.com."
  recordsets_name = split(".", local.googleapis_url)[0]
}

# This will create an global address for Private service connect and reserve an static IP for private service connect
resource "google_compute_global_address" "private_service_connect" {
  provider     = google-beta
  project      = var.project_id
  name         = var.private_service_connect_name
  address_type = "INTERNAL"
  purpose      = "PRIVATE_SERVICE_CONNECT"
  network      = var.network_self_link
  address      = var.private_service_connect_ip
}

# This will create a global forwarding rule which will be used specify private service connect forwarding rule target and help in connection between HPC cluster and storage bucket with regular service perimeter 
resource "google_compute_global_forwarding_rule" "forwarding_rule_private_service_connect" {
  provider              = google-beta
  project               = var.project_id
  name                  = var.forwarding_rule_name
  target                = var.forwarding_rule_target
  network               = var.network_self_link
  ip_address            = google_compute_global_address.private_service_connect.id
  load_balancing_scheme = ""
}
