variable "workload" {
  type = string
}

variable "subnet" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "ami" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "userdata" {
  type = string
}

variable "rds_security_group_id" {
  type = string
}

variable "appserver_route_table_id" {
  type = string
}
