terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.34.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

locals {
  workload = "tailscale"
}

module "kms" {
  source = "./modules/kms"
}

module "vpc" {
  source   = "./modules/vpc"
  region   = var.aws_region
  workload = local.workload
}

module "database" {
  source         = "./modules/rds"
  workload       = local.workload
  instance_class = var.rds_instance_class
  kms_key_arn    = module.kms.kms_key_arn

  username = var.rds_username
  password = var.rds_password

  vpc_id             = module.vpc.vpc_id
  subnets            = module.vpc.rds_subnets
  availability_zones = module.vpc.availability_zones
}

module "nat" {
  source        = "./modules/nat"
  workload      = local.workload
  vpc_id        = module.vpc.vpc_id
  subnet        = module.vpc.nat_subnet_id
  instance_type = var.nat_instance_type
  ami           = var.nat_ami
  userdata      = var.nat_userdata
}

module "tailscale" {
  source        = "./modules/tailscale"
  workload      = local.workload
  vpc_id        = module.vpc.vpc_id
  subnet        = module.vpc.tailscale_subnet_id
  instance_type = var.ts_instance_type
  ami           = var.ts_ami
  userdata      = var.ts_userdata

  nat_route_table_id       = module.vpc.nat_route_table_id
  nat_network_interface_id = module.nat.network_interface_id
  rds_security_group_id    = module.database.security_group_id
}
