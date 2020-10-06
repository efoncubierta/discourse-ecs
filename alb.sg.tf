resource "aws_security_group" "alb" {
  name        = var.alb_sg_name
  description = "Security group for the Discourse ALB"
  vpc_id      = var.vpc_id
  tags        = local.alb_tags
}

resource "aws_security_group_rule" "alb_discourse_out" {
  security_group_id        = aws_security_group.alb.id
  source_security_group_id = aws_security_group.discourse_service.id
  type                     = "egress"
  from_port                = 3000
  to_port                  = 3000
  protocol                 = "tcp"
}

resource "aws_security_group_rule" "discourse_alb_in" {
  security_group_id        = aws_security_group.discourse_service.id
  source_security_group_id = aws_security_group.alb.id
  type                     = "ingress"
  from_port                = 3000
  to_port                  = 3000
  protocol                 = "tcp"
}

resource "aws_security_group_rule" "alb_http80_in" {
  security_group_id = aws_security_group.alb.id
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = [ "0.0.0.0/0" ]
}

resource "aws_security_group_rule" "alb_http443_in" {
  security_group_id = aws_security_group.alb.id
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = [ "0.0.0.0/0" ]
}