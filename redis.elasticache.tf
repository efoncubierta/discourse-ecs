resource "aws_elasticache_subnet_group" "discourse" {
  name       = var.redis_subnet_group_name
  subnet_ids = var.subnet_ids
}

resource "aws_elasticache_cluster" "discourse" {
  cluster_id           = var.redis_cluster_name
  engine               = "redis"
  node_type            = var.redis_node_type
  num_cache_nodes      = var.redis_num_cache_nodes
  parameter_group_name = var.redis_parameter_group_name
  engine_version       = var.redis_engine_version
  port                 = var.redis_port
  security_group_ids   = [ aws_security_group.redis.id ]
  subnet_group_name    = aws_elasticache_subnet_group.discourse.name
  tags                 = local.redis_tags
}