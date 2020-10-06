resource "aws_ecs_service" "discourse" {
  name             = var.service_name
  cluster          = aws_ecs_cluster.discourse.id
  task_definition  = aws_ecs_task_definition.discourse.arn
  desired_count    = var.service_task_desired_count
  platform_version = "1.4.0"
  launch_type      = "FARGATE"

  network_configuration {
    assign_public_ip = var.service_assign_public_ip
    subnets          = var.subnet_ids
    security_groups  = [ aws_security_group.discourse_service.id ]
  }

  health_check_grace_period_seconds = 300
  
  load_balancer {
    container_name   = var.discourse_container_name
    container_port   = 3000
    target_group_arn = aws_lb_target_group.discourse.arn
  }
}