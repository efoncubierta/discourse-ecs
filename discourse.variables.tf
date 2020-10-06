variable "discourse_version" {
  description = "Version of Discourse"
  type        = string
  default     = "2.5.2"
}

variable "discourse_hostname" {
  description = "Public hostname of the Discourse service"
  type        = string
}

variable "discourse_username" {
  description = "Discourse first user username"
  type        = string
  default     = "admin"
}

variable "discourse_email" {
  description = "Discourse email address"
  type        = string
  default     = "user@example.com"
}