resource "aws_iam_role" "codebuild" {
  count = var.artifact_bucket == null ? 0 : 1

  name = "${var.name_prefix}-codebuild-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect    = "Allow"
      Principal = {
        Service = "codebuild.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_policy" "codebuild_logs" {
  count      = var.artifact_bucket == null ? 0 : 1

  name = "${var.name_prefix}-codebuild-logs"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Resource = "arn:aws:logs:*:*:log-group:/aws/codebuild/*"
      }
    ]
  })
}

resource "aws_iam_policy" "codebuild_artifacts_s3" {
  count = var.artifact_bucket == null ? 0 : 1

  name = "${var.name_prefix}-codebuild-artifacts-s3"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:GetObject",
          "s3:GetObjectVersion",
          "s3:PutObject"
        ]
        Resource = [
          "arn:aws:s3:::${var.artifact_bucket}",
          "arn:aws:s3:::${var.artifact_bucket}/*"
        ]
      },
      {
        Effect = "Allow"
        Action = "s3:ListBucket"
        Resource = "arn:aws:s3:::${var.artifact_bucket}"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "codebuild_artifacts_attach" {
  count      = var.artifact_bucket == null ? 0 : 1

  role       = aws_iam_role.codebuild[0].name
  policy_arn = aws_iam_policy.codebuild_artifacts_s3[0].arn

  # policy_arn = aws_iam_policy.codebuild_artifacts_s3.arn
}


resource "aws_iam_role_policy_attachment" "codebuild_logs_attach" {
  count      = var.artifact_bucket == null ? 0 : 1

  role       = aws_iam_role.codebuild[0].name
  policy_arn = aws_iam_policy.codebuild_logs[0].arn
}

#resource "aws_iam_role_policy_attachment" "codebuild_managed" {
#  role       = aws_iam_role.codebuild.name
#  policy_arn = "arn:aws:iam::aws:policy/AWSCodeBuildDeveloperAccess"
#}


# AWS managed policy (safe for prod)
resource "aws_iam_role_policy_attachment" "codebuild_main" {
  count      = var.artifact_bucket == null ? 0 : 1

  #  role       = aws_iam_role.codebuild.name
  role = aws_iam_role.codebuild[0].name

  policy_arn = "arn:aws:iam::aws:policy/AWSCodeBuildDeveloperAccess"
}

# ECR access
resource "aws_iam_role_policy_attachment" "codebuild_ecr" {
  count      = var.artifact_bucket == null ? 0 : 1

  # role       = aws_iam_role.codebuild.name
  role       = aws_iam_role.codebuild[0].name

  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryPowerUser"
}
