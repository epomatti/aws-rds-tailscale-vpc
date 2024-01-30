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
  workload = "tailgate"
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
  source      = "./modules/rds"
  workload    = local.workload
  kms_key_arn = module.kms.kms_key_arn

  vpc_id             = module.vpc.vpc_id
  subnets            = module.vpc.private_subnets
  availability_zones = module.vpc.availability_zones

  instance_class = var.rds_instance_class
}
