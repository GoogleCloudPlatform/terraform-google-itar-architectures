#data block for organization
data "google_organization" "org" {
  organization = var.parent_id
}

#This module will create access policy which is a container for AccessLevels (which define the necessary attributes to use GCP services) and ServicePerimeters (which define regions of services able to freely pass data within a perimeter)
resource "google_access_context_manager_access_policy" "access_policy" {
  provider = google
  parent   = data.google_organization.org.id
  title    = var.policy_name
  scopes   = var.scopes
}

#This module will be used to add/give access to members who will not be restricted by the access level context policy and will be able to access the storage service API and storage buckets
module "access_level_members" {
  source  = "terraform-google-modules/vpc-service-controls/google//modules/access_level"
  policy  = google_access_context_manager_access_policy.access_policy.name
  name    = "access_members"
  members = var.members
}

#This will create a reguler service perimeter for google cloud storage API, which will restrict allusers to access storage buckets and only give access to selected members
module "regular_service_perimeter_1" {
  source              = "terraform-google-modules/vpc-service-controls/google//modules/regular_service_perimeter"
  policy              = google_access_context_manager_access_policy.access_policy.name
  perimeter_name      = var.perimeter_name
  description         = "Perimeter shielding projects"
  resources           = [var.protected_project_ids["number"]]
  access_levels       = [module.access_level_members.name]
  restricted_services = ["storage.googleapis.com"]
  shared_resources = {
    all = [var.protected_project_ids["number"]]
  }
}
