resource "random_password" "rds_password" {
  for_each         = var.rds
  length           = 9
  special          = true
  override_special = "_!%^"
}

resource "aws_secretsmanager_secret" "rds_secret" {
  for_each = var.rds
  name     = "${each.value.db_identifier}-secrets"
  recovery_window_in_days = 0
}

resource "aws_secretsmanager_secret_version" "rds_secret_version" {
  for_each      = var.rds
  secret_id     = aws_secretsmanager_secret.rds_secret[each.key].id
  secret_string = jsonencode({
    password = random_password.rds_password[each.key].result
  })
}