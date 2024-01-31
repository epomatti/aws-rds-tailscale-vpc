# Project
aws_region = "us-east-2"

# Tailscale Subnet Router
ami           = "ami-0748d13ffbc370c2b"
instance_type = "t4g.nano"
userdata      = "ubuntu.sh"

# ami           = "ami-0c758b376a9cf7862"
# instance_type = "t4g.nano"
# userdata      = "debian.sh"

# RDS
rds_instance_class = "db.t4g.micro"
rds_username       = "tailscale"
rds_password       = "p4ssw0rd"
