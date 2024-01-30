locals {
  db_name = "${var.workload}db"
}

resource "aws_db_instance" "default" {
  identifier = "rds-${var.workload}"

  db_name        = local.db_name
  engine         = "postgres"
  engine_version = "16.1"

  username   = var.username
  password   = var.password
  kms_key_id = var.kms_key_arn

  iam_database_authentication_enabled = true

  # Network
  db_subnet_group_name = aws_db_subnet_group.default.name
  availability_zone    = var.availability_zones[0]
  publicly_accessible  = false

  # Resources
  instance_class        = var.instance_class
  allocated_storage     = 20
  max_allocated_storage = 30
  storage_type          = "gp3"

  # Valid until 2061 with automatic rotation
  ca_cert_identifier = "rds-ca-rsa4096-g1"

  # Security
  storage_encrypted      = true
  vpc_security_group_ids = [aws_security_group.allow_postgresql.id]

  # Multi-AZ
  multi_az = false

  # Upgrades
  auto_minor_version_upgrade  = true
  allow_major_version_upgrade = true
  apply_immediately           = true

  blue_green_update {
    enabled = false
  }

  # Protect
  deletion_protection      = false
  skip_final_snapshot      = true
  delete_automated_backups = true

  # Monitoring
  performance_insights_enabled = false
}

### VPC ###
resource "aws_db_subnet_group" "default" {
  name       = var.workload
  subnet_ids = var.subnets
}

data "aws_vpc" "selected" {
  id = var.vpc_id
}

resource "aws_security_group" "allow_postgresql" {
  name        = "rds-${var.workload}"
  description = "Allow TLS inbound traffic to RDS PostgreSQL"
  vpc_id      = var.vpc_id

  tags = {
    Name = "sg-rds-${var.workload}"
  }
}

resource "aws_security_group_rule" "ingress" {
  description       = "Allows private connection to the database"
  type              = "ingress"
  from_port         = 5432
  to_port           = 5432
  protocol          = "tcp"
  cidr_blocks       = [data.aws_vpc.selected.cidr_block]
  security_group_id = aws_security_group.allow_postgresql.id
}
