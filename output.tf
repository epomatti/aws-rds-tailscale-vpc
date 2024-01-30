output "postgresql_address" {
  value = module.database.address
}


output "postgresql_connection_string" {
  value = module.database.connection_string
}
