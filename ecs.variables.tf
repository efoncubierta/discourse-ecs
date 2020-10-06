variable "cluster_name" {
  description = "Name of the ECS cluster"
  type        = string
  default     = "discourse"
}

variable "cluster_tags" {
  description = "Tags to attach to the ECS cluster"
  type        = map(string)
  default     = {}
}

variable "service_name" {
  description = "Name of the ECS Service that runs Discourse"
  type        = string
  default     = "discourse"
}

variable "service_task_desired_count" {
  description = "Desired number of Discourse tasks running"
  type        = number
  default     = 1
}

variable "service_sg_name" {
  description = "Name of the ECS Service security group"
  type        = string
  default     = "discourse-ecs-service"
}

variable "service_assign_public_ip" {
  description = "Indicates whether or not to assign a public IP to the service (only when subnets are public)"
  type        = bool
  default     = false
}

variable "service_tags" {
  description = "Tags to attach to all ECS Service resources"
  type    = map(string)
  default = {}
}

variable "discourse_container_name" {
  description = "Name of the Discourse container"
  default     = "discourse"
}

variable "discourse_container_image" {
  description = "Docker image for the Discourse container"
  default     = "docker.io/bitnami/discourse"
}

variable "discourse_container_cpu" {
  description = "CPU units to allocate to Discourse container"
  default     = 0
}

variable "discourse_container_memory" {
  description = "Memory to allocate to Discourse container"
  default    = 1024
}

variable "discourse_container_memory_reservation" {
  description = "Memory reservation to allocate to Discourse container"
  default    = 1024
}

variable "sidekiq_container_name" {
  description = "Name of the Discourse Sidekiq container"
  default     = "sidekiq"
}

variable "sidekiq_container_image" {
  description = "Docker image for the Discourse Sidekiq container"
  default     = "docker.io/bitnami/discourse"
}

variable "sidekiq_container_cpu" {
  description = "CPU units to allocate to Discourse Sidekiq container"
  default     = 0
}

variable "sidekiq_container_memory" {
  description = "Memory to allocate to Discourse Sidekiq container"
  default     = 1024
}

variable "sidekiq_container_memory_reservation" {
  description = "Memory reservation to allocate to Discourse Sidekiq container"
  default     = 1024
}

variable "task_tags" {
  description = "Tags to attach to all Discourse task resources"
  type    = map(string)
  default = {}
}