#Creating IAP Firewall rule and allowing IAP CIDR block 
resource "google_compute_firewall" "iap_firewall" {
  project       = var.project_id
  name          = var.name
  network       = var.network
  source_ranges = ["35.235.240.0/20"]
  allow {
    protocol = "tcp"
    ports    = ["80", "22", ]
  }
}

# This will be used to control which users and groups are allowed to use IAP Tunnel and which VM instances they're allowed to connect to.
resource "google_iap_tunnel_instance_iam_binding" "policy" {
  provider = google-beta
  project  = var.project_id
  instance = var.instance_name
  zone     = var.zone
  role     = "roles/iap.tunnelResourceAccessor"
  members  = var.members
}