output "connection_string" {
  value = "postgresql://${local.username}:${local.password}@${aws_db_instance.default.address}:5432/${local.db_name}"
}
