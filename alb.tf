resource "aws_lb" "discourse" {
  name                             = var.alb_name
  enable_cross_zone_load_balancing = true
  internal                         = false
  load_balancer_type               = "application"
  security_groups                  = [ aws_security_group.alb.id ]
  subnets                          = var.subnet_ids
  tags                             = local.alb_tags
}

resource "aws_lb_listener" "discourse_80" {
  load_balancer_arn  = aws_lb.discourse.arn
  port               = "80"
  protocol           = "HTTP"

  default_action {
    type            = "redirect"

    redirect {
      port          = "443"
      protocol      = "HTTPS"
      status_code   = "HTTP_301"
    }
  }
}

resource "aws_lb_listener" "discourse" {
  load_balancer_arn  = aws_lb.discourse.arn
  port               = "443"
  protocol           = "HTTPS"
  ssl_policy         = "ELBSecurityPolicy-2016-08"
  certificate_arn    = var.alb_certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.discourse.arn
  }
}

resource "aws_lb_target_group" "discourse" {
  name        = var.alb_tg_name
  port        = "3000"
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"

  health_check {
    interval            = 30
    path                = "/srv/status"
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = "5"
    healthy_threshold   = "2"
    unhealthy_threshold = "2"
    matcher             = "200"
  }

  tags = local.alb_tags
}