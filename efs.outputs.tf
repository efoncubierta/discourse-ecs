output "efs_id" {
  description = "ID of the Discourse EFS"
  value       = aws_efs_file_system.discourse.id
}

output "efs_arn" {
  description = "ARN of the Discourse EFS"
  value       = aws_efs_file_system.discourse.arn
}

output "efs_dns_name" {
  description = "DNS of the Discourse EFS"
  value       = aws_efs_file_system.discourse.dns_name
}

output "efs_sg_id" {
  description = "ID of the EFS security group"
  value       = aws_security_group.efs.id
}