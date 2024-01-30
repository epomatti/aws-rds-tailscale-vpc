variable "aws_region" {
  type    = string
  default = "us-east-2"
}

variable "rds_instance_class" {
  type    = string
  default = "db.t4g.small"
}

variable "athena_user_principal" {
  type = string
}