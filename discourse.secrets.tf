resource "random_string" "discourse_password" {
  length           = 16
  override_special = "!#*()-_=+[]{}:"
}