resource "aws_db_subnet_group" "discourse" {
  name       = var.postgres_subnet_group_name
  subnet_ids = var.subnet_ids
  tags       = local.postgres_tags
}

resource "aws_rds_cluster" "discourse" {
  cluster_identifier        = var.postgres_cluster_name
  db_subnet_group_name      = aws_db_subnet_group.discourse.name
  engine                    = var.postgres_engine
  engine_version            = var.postgres_engine_version
  storage_encrypted         = true
  master_username           = var.postgres_admin_user
  master_password           = random_string.postgres_admin_password.result
  final_snapshot_identifier = var.postgres_cluster_name
  deletion_protection       = var.postgres_enable_deletion_protection
  vpc_security_group_ids = [
    aws_security_group.postgres.id
  ]
}

resource "aws_rds_cluster_instance" "discourse" {
  count              = var.postgres_instance_count
  identifier         = format("%s%02d", var.postgres_cluster_name, count.index + 1)
  cluster_identifier = aws_rds_cluster.discourse.id
  instance_class     = var.postgres_instance_type
  engine             = aws_rds_cluster.discourse.engine
  engine_version     = aws_rds_cluster.discourse.engine_version
  tags               = local.postgres_tags
}