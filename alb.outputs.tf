output "alb_id" {
  description = "ID of the Discourse ALB"
  value       = aws_lb.discourse.id
}

output "alb_arn" {
  description = "ARN of the Discourse ALB"
  value       = aws_lb.discourse.arn
}

output "alb_dns_name" {
  description = "DNS of the Discourse ALB"
  value       = aws_lb.discourse.dns_name
}

output "alb_sg_id" {
  description = "ID of the ALB security group"
  value       = aws_security_group.alb.id
}