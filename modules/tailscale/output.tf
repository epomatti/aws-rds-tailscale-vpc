output "network_interface_id" {
  value = aws_instance.nat_instance.primary_network_interface_id
}

output "security_group_id" {
  value = aws_security_group.nat_instance.id
}
