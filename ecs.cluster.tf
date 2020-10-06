resource "aws_ecs_cluster" "discourse" {
  name = var.cluster_name
  tags = local.cluster_tags
}