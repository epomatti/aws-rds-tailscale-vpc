output "address" {
  value = aws_db_instance.default.address
}

output "connection_string" {
  value = "jdbc:postgresql://${aws_db_instance.default.address}:5432/${local.db_name}"
}

output "security_group_id" {
  value = aws_security_group.allow_postgresql.id
}
