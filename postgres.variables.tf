variable "postgres_subnet_group_name" {
  description = "Name of the Postgres subnet group"
  type        = string
  default     = "discourse-subnets"
}

variable "postgres_cluster_name" {
  description = "Name of the Postgres cluster"
  type        = string
  default     = "discourse-db"
}

variable "postgres_instance_count" {
  description = "Number of RDS instances"
  type        = number
  default     = 1
}

variable "postgres_instance_type" {
  description = "Type of RDS instance"
  type        = string
  default     = "db.t3.medium"
}

variable "postgres_engine" {
  description = "Type of DB engine"
  type        = string
  default     = "aurora-postgresql"
}

variable "postgres_engine_version" {
  description = "Version of the DB engine"
  type        = string
  default     = "10.13"
}

variable "postgres_storage_size" {
  description = "Size of the DB storage (GB)"
  type        = number
  default     = 50
}

variable "postgres_backup_retention_period" {
  description = "How many days backups are retained before deletion"
  type        = number
  default     = 15
}

variable "postgres_admin_user" {
  description = "Username of the administrator of the database"
  type        = string
  default     = "dbadmin"
}

variable "postgres_enable_deletion_protection" {
  description = "Enable deletion protection"
  type        = bool
  default     = true
}

variable "postgres_name" {
  description = "Name of the Discourse database"
  type        = string
  default     = "discourse"
}

variable "postgres_user" {
  description = "Name of the Discourse database user"
  type        = string
  default     = "discourse"
}

variable "postgres_sg_name" {
  description = "Name of the Postgres security group"
  type        = string
  default     = "discourse-postgres"
}

variable "postgres_tags" {
  description = "Tags to attach to all Postgres resources"
  type        = map(string)
  default     = {}
}