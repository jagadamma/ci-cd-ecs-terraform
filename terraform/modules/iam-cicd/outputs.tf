output "codepipeline_role_arn" {
  value = aws_iam_role.codepipeline.arn
}

output "codebuild_role_arn" {
  value = var.artifact_bucket == null ? null : aws_iam_role.codebuild[0].arn
}

output "codedeploy_role_arn" {
  value = aws_iam_role.codedeploy.arn
}

