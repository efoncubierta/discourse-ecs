variable "log_group_name" {
  description = "Name of the log group in CloudWatch for Discourse"
  default     = "discourse"
}

variable "log_retention_in_days" {
  description = "How many days to keep the logs"
  default     = 30
}