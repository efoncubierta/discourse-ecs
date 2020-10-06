resource "aws_security_group" "discourse_service" {
  name        = var.service_sg_name
  description = "Security group for the Discourse ECS Service"
  vpc_id      = var.vpc_id
  tags        = var.service_tags
}

resource "aws_security_group_rule" "discourse_service_internet_out" {
  security_group_id = aws_security_group.discourse_service.id
  type              = "egress"
  from_port         = 0
  to_port           = 65535
  protocol          = -1
  cidr_blocks       = [ "0.0.0.0/0" ]
}