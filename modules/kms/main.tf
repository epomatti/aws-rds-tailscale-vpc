data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

locals {
  aws_account_id        = data.aws_caller_identity.current.account_id
  aws_region            = data.aws_region.current.name
  aws_account_principal = "arn:aws:iam::${local.aws_account_id}:root"
}

resource "aws_kms_key" "default" {
  description             = "RDS PostgreSQL CMK for Athena"
  key_usage               = "ENCRYPT_DECRYPT"
  is_enabled              = true
  deletion_window_in_days = 30
  enable_key_rotation     = true
  multi_region            = false
}

resource "aws_kms_alias" "default" {
  name          = "alias/rds-postgresql-for-athena"
  target_key_id = aws_kms_key.default.key_id
}

resource "aws_kms_key_policy" "default" {
  key_id = aws_kms_key.default.id

  policy = jsonencode({
    Version = "2012-10-17"
    Id      = "RDSPostgreSQL"
    Statement = [
      {
        Sid    = "Enable IAM User Permissions"
        Effect = "Allow"
        Principal = {
          AWS = "${local.aws_account_principal}"
        }
        Action   = "kms:*"
        Resource = "*"
      }
    ]
  })
}
