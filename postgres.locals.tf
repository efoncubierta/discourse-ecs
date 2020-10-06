locals {
  postgres_tags = merge(var.tags, var.postgres_tags)
}