resource "aws_kms_key" "kms" {
  for_each = var.rds

  description             = "KMS key for RDS ${each.key}"
  enable_key_rotation     = true
  multi_region            = false
  deletion_window_in_days = 7

  lifecycle {
    ignore_changes = [tags, tags_all]
  }

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "EnableRootPermissions"
        Effect = "Allow"
        Principal = {
          AWS = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
        }
        Action   = "kms:*"
        Resource = "*"
      },
      {
        Sid    = "AllowRDSUsage"
        Effect = "Allow"
        Principal = {
          Service = "rds.amazonaws.com"
        }
        Action = [
          "kms:Encrypt",
          "kms:Decrypt",
          "kms:ReEncrypt*",
          "kms:GenerateDataKey*",
          "kms:DescribeKey"
        ]
        Resource = "*"
      }
    ]
  })

  tags = merge(
    var.common_tags,
    {
      Name = each.value.kms_key_name
    }
  )
}

resource "aws_kms_alias" "kms" {
  for_each      = var.rds
  name          = "alias/${each.value.kms_key_name}"
  target_key_id = aws_kms_key.kms[each.key].key_id
}
