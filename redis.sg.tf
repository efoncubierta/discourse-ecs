resource "aws_security_group" "redis" {
  name        = var.redis_sg_name
  description = "Security group for the Discourse Redis instances"
  vpc_id      = var.vpc_id
  tags        = var.redis_tags
}

resource "aws_security_group_rule" "redis_discourse_in" {
  security_group_id        = aws_security_group.redis.id
  source_security_group_id = aws_security_group.discourse_service.id
  type                     = "ingress"
  from_port                = var.redis_port
  to_port                  = var.redis_port
  protocol                 = "tcp"
}

resource "aws_security_group_rule" "discourse_redis_out" {
  security_group_id        = aws_security_group.discourse_service.id
  source_security_group_id = aws_security_group.redis.id
  type                     = "egress"
  from_port                = var.redis_port
  to_port                  = var.redis_port
  protocol                 = "tcp"
}