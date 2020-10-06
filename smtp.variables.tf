variable "smtp_auth" {
  description = "Authentication method for the SMTP server"
  type        = string
  default     = "login"
}

variable "smtp_host" {
  description = "Host of the SMTP server"
  type        = string
  default     = ""
}

variable "smtp_port" {
  description = "Port of the SMTP server"
  type        = number
  default     = null
}

variable "smtp_user" {
  description = "User of the SMTP server"
  type        = string
  default     = ""
}

variable "smtp_password" {
  description = "User password of the SMTP server"
  type        = string
  default     = ""
}

variable "smtp_tls" {
  description = "Enable TLS for SMTP"
  type        = string
  default     = "yes"
}