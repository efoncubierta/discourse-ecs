resource "aws_route53_record" "discourse_alb" {
  zone_id = var.route53_zone_id
  name    = var.discourse_hostname
  type    = "A"

  alias {
    name                   = aws_lb.discourse.dns_name
    zone_id                = aws_lb.discourse.zone_id
    evaluate_target_health = true
  }
}