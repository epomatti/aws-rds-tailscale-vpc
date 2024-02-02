# Project
aws_region = "us-east-2"

# NAT Instance
create_nat_instance = false
nat_ami             = "ami-0748d13ffbc370c2b"
nat_instance_type   = "t4g.nano"
nat_userdata        = "ubuntu-nat.sh"

# Tailscale Subnet Router
create_ts_subnet_router = false
ts_instance_type        = "t4g.micro"
# ts_ami                  = "ami-0c758b376a9cf7862"
# ts_userdata             = "debian-tailscale.sh"
ts_ami      = "ami-0748d13ffbc370c2b"
ts_userdata = "ubuntu-tailscale.sh"

# App server
create_appserver        = false
appserver_ami           = "ami-0748d13ffbc370c2b"
appserver_instance_type = "t4g.nano"

# RDS
rds_instance_class = "db.t4g.micro"
rds_username       = "tailscale"
rds_password       = "p4ssw0rd"
