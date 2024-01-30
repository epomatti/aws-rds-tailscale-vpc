variable "aws_region" {
  type = string
}

### Tailgate ###
variable "instance_type" {
  type = string
}

variable "userdata" {
  type = string
}

variable "ami" {
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
