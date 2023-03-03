output "policy_id" {
  description = "Resource name of the AccessPolicy."
  value       = google_access_context_manager_access_policy.access_policy.name
}

output "policy_name" {
  description = "Name of the parent policy"
  value       = var.policy_name
}

output "access_level_name" {
  description = "Access level name of the Access Policy."
  value       = var.access_level_name
}

output "protected_project_id" {
  description = "Project id of the project INSIDE the regular service perimeter"
  value       = var.protected_project_ids["id"]
}
