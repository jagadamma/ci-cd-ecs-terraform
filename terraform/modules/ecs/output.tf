output "cluster_name" {
  value = aws_ecs_cluster.ecs.name
}

output "service_names" {
  value = {
    for k, svc in aws_ecs_service.service :
    k => svc.name
  }
}

output "blue_tg_names" {
  value = {
    for k, tg in aws_lb_target_group.blue :
    k => tg.name
  }
}

output "green_tg_names" {
  value = {
    for k, tg in aws_lb_target_group.green :
    k => tg.name
  }
}

output "alb_listener_arn" {
  value = aws_lb_listener.prod.arn
}


output "alb_test_listener_arn" {
  value = aws_lb_listener.test.arn
}
