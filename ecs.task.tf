resource "aws_ecs_task_definition" "discourse" {
  family                   = var.discourse_container_name
  container_definitions    = jsonencode(local.container_definitions)
  cpu                      = local.task_cpu
  memory                   = local.task_memory
  task_role_arn            = aws_iam_role.task.arn
  execution_role_arn       = aws_iam_role.task_execution.arn
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]

  volume {
    name = "bitnami-data"
    efs_volume_configuration {
      file_system_id = aws_efs_file_system.discourse.id
      root_directory = "/"
    }
  }

  tags = local.task_tags
}