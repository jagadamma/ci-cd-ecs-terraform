locals {
  ecs_task_execution_role_arn = var.use_existing_iam ? data.aws_iam_role.ecs_task_execution[0].arn : module.iam_ecs.ecs_task_execution_role_arn
  ecs_task_role_arn           = var.use_existing_iam ? data.aws_iam_role.ecs_task[0].arn : module.iam_ecs.ecs_task_role_arn

  codebuild_role_arn    = var.use_existing_iam ? data.aws_iam_role.codebuild[0].arn : module.iam_cicd.codebuild_role_arn
  codepipeline_role_arn = var.use_existing_iam ? data.aws_iam_role.codepipeline[0].arn : module.iam_cicd.codepipeline_role_arn
  codedeploy_role_arn   = var.use_existing_iam ? data.aws_iam_role.codedeploy[0].arn : module.iam_cicd.codedeploy_role_arn
}
