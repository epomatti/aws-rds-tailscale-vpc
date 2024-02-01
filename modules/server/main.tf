locals {
  name = "appserver"
}
resource "aws_iam_instance_profile" "nat_instance" {
  name = "${var.workload}-${local.name}"
  role = aws_iam_role.nat_instance.id
}

resource "aws_instance" "nat_instance" {
  ami           = var.ami
  instance_type = var.instance_type

  associate_public_ip_address = false
  subnet_id                   = var.subnet
  vpc_security_group_ids      = [aws_security_group.nat_instance.id]
  iam_instance_profile        = aws_iam_instance_profile.nat_instance.id

  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "required"
  }

  monitoring    = false
  ebs_optimized = true

  root_block_device {
    encrypted   = true
    volume_type = "gp3"
  }

  lifecycle {
    ignore_changes = [
      ami,
      associate_public_ip_address
    ]
  }

  tags = {
    Name = "${var.workload}-${local.name}"
  }
}

### IAM Role ###

resource "aws_iam_role" "nat_instance" {
  name = "${var.workload}-${local.name}"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "AmazonSSMManagedInstanceCore" {
  role       = aws_iam_role.nat_instance.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_security_group" "nat_instance" {
  name        = "ec2-ssm-${var.workload}-${local.name}"
  description = "Controls access for EC2 via Session Manager"
  vpc_id      = var.vpc_id

  tags = {
    Name = "sg-ssm-${var.workload}-${local.name}"
  }
}

data "aws_vpc" "selected" {
  id = var.vpc_id
}

resource "aws_security_group_rule" "egress_http" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.nat_instance.id
}

# resource "aws_security_group_rule" "egress_https" {
#   type              = "egress"
#   from_port         = 0
#   to_port           = 443
#   protocol          = "TCP"
#   cidr_blocks       = ["0.0.0.0/0"]
#   security_group_id = aws_security_group.nat_instance.id
# }
