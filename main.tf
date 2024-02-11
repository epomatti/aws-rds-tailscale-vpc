terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.36.0"
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

module "server" {
  count         = var.create_appserver ? 1 : 0
  source        = "./modules/server"
  workload      = local.workload
  vpc_id        = module.vpc.vpc_id
  subnet        = module.vpc.appserver_subnet_id
  instance_type = var.appserver_instance_type
  ami           = var.appserver_ami
}

module "ssm" {
  source = "./modules/ssm"
}

module "tailscale" {
  count         = var.create_ts_subnet_router ? 1 : 0
  source        = "./modules/tailscale"
  workload      = local.workload
  vpc_id        = module.vpc.vpc_id
  subnet        = module.vpc.tailscale_subnet_id
  instance_type = var.ts_instance_type
  ami           = var.ts_ami
  userdata      = var.ts_userdata

  depends_on = [module.ssm]
}

resource "aws_route" "nat" {
  count                  = var.create_ts_subnet_router ? 1 : 0
  route_table_id         = module.vpc.appserver_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  network_interface_id   = module.tailscale[0].primary_network_interface_id
}

# module "nat_instance" {
#   count                    = var.create_nat_instance ? 1 : 0
#   source                   = "./modules/nat/instance"
#   workload                 = local.workload
#   vpc_id                   = module.vpc.vpc_id
#   subnet                   = module.vpc.nat_subnet_id
#   instance_type            = var.nat_instance_type
#   ami                      = var.nat_ami
#   userdata                 = var.nat_userdata
#   appserver_route_table_id = module.vpc.appserver_route_table_id
# }

# module "nat-gateway" {
#   source                   = "./modules/nat/gateway"
#   workload                 = local.workload
#   subnet                   = module.vpc.nat_subnet_id
#   tailscale_route_table_id = module.vpc.tailscale_route_table_id
# }
