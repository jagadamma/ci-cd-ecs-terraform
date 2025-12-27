locals {
  ecs_task_execution_role_arn = var.use_existing_iam ? data.aws_iam_role.ecs_task_execution[0].arn : module.iam_ecs.ecs_task_execution_role_arn
  ecs_task_role_arn           = var.use_existing_iam ? data.aws_iam_role.ecs_task[0].arn : module.iam_ecs.ecs_task_role_arn
}

