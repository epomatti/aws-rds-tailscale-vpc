variable "aws_region" {
  type = string
}

### NAT ###
variable "nat_instance_type" {
  type = string
}

variable "nat_userdata" {
  type = string
}

variable "nat_ami" {
  type = string
}

### Tailgate ###
variable "create_ts_subnet_router" {
  type = bool
}

variable "ts_instance_type" {
  type = string
}

variable "ts_userdata" {
  type = string
}

variable "ts_ami" {
  type = string
}

### RDS ###
variable "rds_instance_class" {
  type = string
}

variable "rds_username" {
  type = string
}

variable "rds_password" {
  type      = string
  sensitive = true
}
