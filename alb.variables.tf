variable "alb_name" {
  description = "Name of the Application Load Balancer"
  type        = string
  default     = "discourse"
}

variable "alb_sg_name" {
  description = "Name of the ALB security group"
  type        = string
  default     = "discourse-alb"
}

variable "alb_tg_name" {
  description = "Name of the ALB Target Group"
  type        = string
  default     = "discourse-service"
}

variable "alb_tags" {
  description = "Tags to attach to all ALB resources"
  type        = map(string)
  default     = {}
}

variable "alb_certificate_arn" {
  description = "ARN of a certificate in ACM"
  type        = string
}