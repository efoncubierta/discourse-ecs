variable "efs_name" {
  description = "Name of the Discourse EFS"
  type        = string
  default     = "discourse"
}

variable "efs_encrypted" {
  description = "Indicates whether the EFS must be encrypted"
  type        = bool
  default     = true
}

variable "efs_tags" {
  description = "Tags to attach to the EFS endpoints"
  type        = map(string)
  default     = {}
}

variable "efs_sg_name" {
  description = "Name of the EFS security group"
  type        = string
  default     = "discourse-efs"
}