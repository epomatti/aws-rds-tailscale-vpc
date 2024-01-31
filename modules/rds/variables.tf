variable "workload" {
  type = string
}

variable "instance_class" {
  type = string
}

variable "kms_key_arn" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "subnets" {
  type = list(string)
}

variable "availability_zones" {
  type = list(string)
}

variable "username" {
  type = string
}

variable "password" {
  type      = string
  sensitive = true
}

variable "tailgate_subnet_router_source_security_group_id" {
  type = string
}
