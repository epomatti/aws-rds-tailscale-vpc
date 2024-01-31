# Project
aws_region = "us-east-2"

# NAT Instance
nat_ami           = "ami-0748d13ffbc370c2b"
nat_instance_type = "t4g.nano"
nat_userdata      = "ubuntu-nat.sh"

# Tailscale Subnet Router
create_ts_subnet_router = false
ts_ami                  = "ami-0748d13ffbc370c2b"
ts_instance_type        = "t4g.nano"
ts_userdata             = "ubuntu-tailscale.sh"

# RDS
rds_instance_class = "db.t4g.micro"
rds_username       = "tailscale"
rds_password       = "p4ssw0rd"
