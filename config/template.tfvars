# Project
aws_region = "us-east-2"

# RDS
rds_instance_class = "db.t4g.micro"
rds_username       = "tailscale"
rds_password       = "p4ssw0rd"

# Tailscale Subnet Router
create_ts_subnet_router = false
ts_instance_type        = "t4g.micro"
ts_ami                  = "ami-0b92f766486312c82"
ts_userdata             = "ubuntu-tailscale-imagebuilder.sh"

# App server
create_appserver        = false
appserver_ami           = "ami-0748d13ffbc370c2b"
appserver_instance_type = "t4g.nano"

# NAT Instance
create_nat_instance = false
nat_ami             = "ami-0748d13ffbc370c2b"
nat_instance_type   = "t4g.nano"
nat_userdata        = "ubuntu-nat.sh"
