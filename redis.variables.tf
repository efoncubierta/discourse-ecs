variable "redis_subnet_group_name" {
  description = "Name of the Redis subnet group"
  type        = string
  default     = "discourse-subnets"
}

variable "redis_cluster_name" {
  description = "Name of the Redis cluster"
  type        = string
  default     = "discourse-cache"
}

variable "redis_node_type" {
  description = "Redis node type"
  type        = string
  default     = "cache.t3.small"
}

variable "redis_num_cache_nodes" {
  description = "Number of Redis nodes"
  type        = number
  default     = 1
}

variable "redis_parameter_group_name" {
  description = "Name of the Redis parameter group"
  type        = string
  default     = "default.redis5.0"
}

variable "redis_engine_version" {
  description = "Version of the Redis engine"
  type        = string
  default     = "5.0.6"
}

variable "redis_tags" {
  description = "Tags to attach to all Redis resources"
  type        = map(string)
  default     = {}
}

variable "redis_sg_name" {
  description = "Name of the Redis security group"
  type        = string
  default     = "discourse-redis"
}

variable "redis_port" {
  description = "Redis port"
  type        = number
  default     = 6379
}