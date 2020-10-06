resource "aws_efs_file_system" "discourse" {
  creation_token = var.efs_name
  encrypted      = var.efs_encrypted

  tags = merge(
    local.efs_tags,
    {
      Name = var.efs_name
    }
  )
}

resource "aws_efs_mount_target" "discourse" {
  for_each        = toset(var.subnet_ids)
  file_system_id  = aws_efs_file_system.discourse.id
  subnet_id       = each.key
  security_groups = [ aws_security_group.efs.id ]
}