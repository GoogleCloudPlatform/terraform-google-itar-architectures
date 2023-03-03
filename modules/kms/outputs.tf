output "keyring" {
  description = "Self link of the keyring."
  value       = var.use_existing_keyring ? data.google_kms_key_ring.existing_key_ring[0].id : google_kms_key_ring.key_ring[0].id
  depends_on = [
    google_kms_crypto_key_iam_binding.owners,
    google_kms_crypto_key_iam_binding.decrypters,
    google_kms_crypto_key_iam_binding.encrypters,
  ]
}

output "keys" {
  description = "Map of key name => key self link."
  value       = local.keys_by_name
  depends_on = [
    google_kms_crypto_key_iam_binding.owners,
    google_kms_crypto_key_iam_binding.decrypters,
    google_kms_crypto_key_iam_binding.encrypters,
  ]
}
