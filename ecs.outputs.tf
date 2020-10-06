output "cluster_id" {
  description = "ID of the Discourse ECS Cluster"
  value       = aws_ecs_cluster.discourse.id
}

output "cluster_arn" {
  description = "ARN of the Discourse ECS Cluster"
  value       = aws_ecs_cluster.discourse.arn
}