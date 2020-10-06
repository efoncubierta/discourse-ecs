resource "aws_security_group" "postgres" {
  name        = var.postgres_sg_name
  description = "Security group for the Discourse Postgres instances"
  vpc_id      = var.vpc_id
  tags        = local.postgres_tags
}

resource "aws_security_group_rule" "postgres_discourse_in" {
  security_group_id        = aws_security_group.postgres.id
  source_security_group_id = aws_security_group.discourse_service.id
  type                     = "ingress"
  from_port                = aws_rds_cluster.discourse.port
  to_port                  = aws_rds_cluster.discourse.port
  protocol                 = "tcp"
}

resource "aws_security_group_rule" "discourse_postgres_out" {
  security_group_id        = aws_security_group.discourse_service.id
  source_security_group_id = aws_security_group.postgres.id
  type                     = "egress"
  from_port                = aws_rds_cluster.discourse.port
  to_port                  = aws_rds_cluster.discourse.port
  protocol                 = "tcp"
}