locals {
  efs_tags = merge(var.tags, var.efs_tags)
}