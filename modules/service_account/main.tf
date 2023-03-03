# Creates new service account in the given project. 
resource "google_service_account" "service_account" {
  account_id   = var.account_id
  project      = var.project_id
  display_name = var.display_name
  description  = var.description
}
