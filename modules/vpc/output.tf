output "availability_zones" {
  value = [local.az1, local.az2]
}

output "vpc_id" {
  value = aws_vpc.main.id
}

output "private_subnets" {
  value = [aws_subnet.private1.id, aws_subnet.private2.id]
}

output "public_subnet" {
  value = aws_subnet.public1.id
}

output "subnet_public1_id" {
  value = aws_subnet.public1.id
}
