locals {
  az1 = "${var.region}a"
  az2 = "${var.region}b"
}

### VPC ###
resource "aws_vpc" "main" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  # Enable DNS hostnames 
  enable_dns_hostnames = true

  tags = {
    Name = "vpc-${var.workload}"
  }
}

### Private Subnet ###
resource "aws_route_table" "rds1" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "rt-${var.workload}-rds1"
  }
}

resource "aws_route_table" "rds2" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "rt-${var.workload}-rds2"
  }
}

resource "aws_subnet" "rds1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.100.0/24"
  availability_zone       = local.az1
  map_public_ip_on_launch = false

  tags = {
    Name = "subnet-${var.workload}-rds1"
  }
}

resource "aws_subnet" "rds2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.101.0/24"
  availability_zone       = local.az2
  map_public_ip_on_launch = false

  tags = {
    Name = "subnet-${var.workload}-rds2"
  }
}

resource "aws_route_table_association" "rds1" {
  subnet_id      = aws_subnet.rds1.id
  route_table_id = aws_route_table.rds1.id
}

resource "aws_route_table_association" "rds2" {
  subnet_id      = aws_subnet.rds2.id
  route_table_id = aws_route_table.rds2.id
}


### Tailscale Subnet Router ###
resource "aws_route_table" "ts" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "rt-${var.workload}-ts"
  }
}

resource "aws_subnet" "ts" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.55.0/24"
  availability_zone       = local.az1
  map_public_ip_on_launch = false

  tags = {
    Name = "subnet-${var.workload}-ts"
  }
}

resource "aws_route_table_association" "ts" {
  subnet_id      = aws_subnet.ts.id
  route_table_id = aws_route_table.ts.id
}


### Internet Gateway ###
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "ig-${var.workload}"
  }
}

### Public Subnet ###
resource "aws_route_table" "nat" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name = "rt-${var.workload}-nat"
  }
}

resource "aws_subnet" "nat" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.0.0/24"
  availability_zone       = local.az1
  map_public_ip_on_launch = false

  tags = {
    Name = "subnet-${var.workload}-nat"
  }
}

resource "aws_route_table_association" "nat" {
  subnet_id      = aws_subnet.nat.id
  route_table_id = aws_route_table.nat.id
}
