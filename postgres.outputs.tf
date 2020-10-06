output "postgres_hostname" {
  description = "Hostname of the Postgres server"
  value       = aws_rds_cluster.discourse.endpoint
}

output "postgres_admin_user" {
  description = "Postgres admin user name"
  value       = var.postgres_admin_user
}

output "postgres_admin_password" {
  description = "Postgres admin user password"
  value       = random_string.postgres_admin_password.result
  sensitive   = true
}

output "postgres_sg_id" {
  description = "ID of the Postgres security group"
  value       = aws_security_group.postgres.id
}