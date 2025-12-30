################################
# LOCALS
################################
locals {
  ordered_services = sort(keys(var.task_definition))
  first_service    = local.ordered_services[0]
}

################################
# APPLICATION LOAD BALANCER
################################
resource "aws_lb" "alb" {
  name               = "${var.name_prefix}-${var.environment}-alb"
  load_balancer_type = "application"
  subnets            = var.public_subnet_ids
  security_groups    = var.alb_security_group_ids
  idle_timeout       = var.alb_idle_timeout
  tags               = var.tags
}

################################
# BLUE TARGET GROUPS
################################
resource "aws_lb_target_group" "blue" {
  for_each = var.task_definition

  name        = "${each.key}-blue-tg"
  port        = each.value.port
  #  protocol    = var.listener_protocol
  protocol = var.health_check.protocol

  vpc_id      = var.vpc_id
  target_type = "ip"

  health_check {
    path                = var.health_check.path
    protocol            = var.health_check.protocol
    matcher             = var.health_check.matcher
    interval            = var.health_check.interval
    timeout             = var.health_check.timeout
    healthy_threshold   = var.health_check.healthy_threshold
    unhealthy_threshold = var.health_check.unhealthy_threshold
  }

  tags = var.tags
}

################################
# GREEN TARGET GROUPS
################################
resource "aws_lb_target_group" "green" {
  for_each = var.task_definition

  name        = "${each.key}-green-tg"
  port        = each.value.port
#  protocol    = var.listener_protocol
  protocol = var.health_check.protocol

  vpc_id      = var.vpc_id
  target_type = "ip"

  health_check {
    path                = var.health_check.path
    protocol            = var.health_check.protocol
    matcher             = var.health_check.matcher
    interval            = var.health_check.interval
    timeout             = var.health_check.timeout
    healthy_threshold   = var.health_check.healthy_threshold
    unhealthy_threshold = var.health_check.unhealthy_threshold
  }

  tags = var.tags
}

################################
# PROD LISTENER (PORT 80)
################################
resource "aws_lb_listener" "prod" {
  load_balancer_arn = aws_lb.alb.arn
  port              = var.listener_ports.prod
  protocol          = var.listener_protocol

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.blue[local.first_service].arn
  }
}

################################
# TEST LISTENER (PORT 9000) - REQUIRED
################################
resource "aws_lb_listener" "test" {
  load_balancer_arn = aws_lb.alb.arn
  port              = var.listener_ports.test
  protocol          = var.listener_protocol

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.green[local.first_service].arn
  }
}

