variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}

variable "subnet_ids" {
  description = "List of Subnet IDs Discourse can be deployed to"
  type        = list(string)
}