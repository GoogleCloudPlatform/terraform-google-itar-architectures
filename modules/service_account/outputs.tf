output "name" {
  description = "The service account name."
  value       = google_service_account.service_account.name
}

output "account_id" {
  description = "The service account id."
  value       = google_service_account.service_account.account_id
}

output "id" {
  description = "The service account id in this format projects/{{project}}/serviceAccounts/{{email}}."
  value       = google_service_account.service_account.id
}

output "email" {
  description = "The service account email."
  value       = google_service_account.service_account.email
}
