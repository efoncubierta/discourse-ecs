locals {
  redis_tags = merge(var.tags, var.redis_tags)
}