resource "random_string" "postgres_admin_password" {
  length           = 16
  override_special = "!#*()-_=+[]{}:"
}

resource "random_string" "postgres_password" {
  length           = 16
  override_special = "!#*()-_=+[]{}:"
}