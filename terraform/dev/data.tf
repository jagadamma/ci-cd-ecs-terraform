
data "aws_iam_role" "ecs_task_execution" {
  count = var.use_existing_iam ? 1 : 0
  name  = "${var.name_prefix}-ecs-task-execution-role"
}

data "aws_iam_role" "ecs_task" {
  count = var.use_existing_iam ? 1 : 0
  name  = "${var.name_prefix}-ecs-task-role"
}

