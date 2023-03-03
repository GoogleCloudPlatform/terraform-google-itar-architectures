output "self_link" {
  description = "Self-link of instance template"
  value       = module.instance_template.self_link
}

output "instances_self_links" {
  description = "List of self-links for compute instances"
  value       = module.compute_instance.instances_self_links
}

output "instances_details" {
  description = "List of all details for compute instances"
  value       = module.compute_instance.instances_details
  sensitive   = true
}

output "available_zones" {
  description = "List of available zones in region"
  value       = module.compute_instance.available_zones
}
