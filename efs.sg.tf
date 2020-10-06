resource "aws_security_group" "efs" {
  name        = var.efs_sg_name
  description = "Security group for the Discourse EFS endpoints"
  vpc_id      = var.vpc_id
  tags        = local.efs_tags
}

resource "aws_security_group_rule" "efs_discourse_in" {
  security_group_id        = aws_security_group.efs.id
  source_security_group_id = aws_security_group.discourse_service.id
  type                     = "ingress"
  from_port                = 2049
  to_port                  = 2049
  protocol                 = "tcp"
}

resource "aws_security_group_rule" "discourse_efs_out" {
  security_group_id        = aws_security_group.discourse_service.id
  source_security_group_id = aws_security_group.efs.id
  type                     = "egress"
  from_port                = 2049
  to_port                  = 2049
  protocol                 = "tcp"
}