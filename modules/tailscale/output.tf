output "security_group_id" {
  value = aws_security_group.default.id
}

output "instance_id" {
  value = aws_instance.default.id
}

output "primary_network_interface_id" {
  value = aws_instance.default.primary_network_interface_id
}
