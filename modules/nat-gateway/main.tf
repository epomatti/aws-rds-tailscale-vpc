resource "aws_eip" "nat" {
  domain = "vpc"
}

resource "aws_nat_gateway" "default" {
  allocation_id = aws_eip.nat.id
  subnet_id     = var.subnet

  tags = {
    Name = "nat-gw-${var.workload}"
  }
}

resource "aws_route" "nat_gateway" {
  route_table_id         = var.tailscale_route_table_id
  nat_gateway_id         = aws_nat_gateway.default.id
  destination_cidr_block = "0.0.0.0/0"
}
