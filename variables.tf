variable "aws_region" {
  type    = string
  default = "us-east-2"
}

variable "rds_instance_class" {
  type    = string
  default = "db.t4g.small"
}

variable "instance_type" {
  type = string
}

variable "userdata" {
  type = string
}

variable "ami" {
  type = string
}
