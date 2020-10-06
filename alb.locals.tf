locals {
  alb_tags = merge(var.tags, var.alb_tags)
}