output "postgresql_address" {
  value = module.database.address
}

output "postgresql_connection_string" {
  value = module.database.connection_string
}

output "tailscale_subnet_router_instance_id" {
  value = module.tailscale[0].instance_id
}
