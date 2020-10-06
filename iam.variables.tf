variable "iam_task_role_policies" {
  description = "List of ARNs of policies to attach to the Task Role"
  type        = list(string)
  default     = []
}

variable "iam_task_execution_role_policies" {
  description = "List of ARNs of policies to attach to the Task Execution Role"
  type        = list(string)
  default     = []
}