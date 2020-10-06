output "discourse_url" {
  description = "Discourse URL"
  value       = format("https://%s", var.discourse_hostname)
}

output "discourse_username" {
  description = "First Discourse user username"
  value       = var.discourse_username
}

output "discourse_password" {
  description = "First Discourse user password"
  value       = random_string.discourse_password.result
  sensitive   = true
}