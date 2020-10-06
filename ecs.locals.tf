locals {
  discourse_container_image = format("%s:%s", var.discourse_container_image, var.discourse_version)
  sidekiq_container_image   = format("%s:%s", var.sidekiq_container_image, var.discourse_version)

  discourse_container_environment = [
    {
      name  = "REDIS_HOST"
      value = aws_elasticache_cluster.discourse.cache_nodes.0.address
    },
    {
      name  = "REDIS_PORT"
      value = tostring(var.redis_port)
    },
    {
      name  = "REDIS_PASSWORD"
      value = ""
    },
    {
      name  = "POSTGRESQL_HOST"
      value = aws_rds_cluster.discourse.endpoint
    },
    {
      name  = "POSTGRESQL_PORT_NUMBER"
      value = tostring(aws_rds_cluster.discourse.port)
    },
    {
      name  = "POSTGRESQL_ROOT_USER"
      value = var.postgres_admin_user
    },
    {
      name  = "POSTGRESQL_ROOT_PASSWORD"
      value = random_string.postgres_admin_password.result
    },
    {
      name  = "POSTGRESQL_CLIENT_CREATE_DATABASE_NAME"
      value = var.postgres_name
    },
    {
      name  = "POSTGRESQL_CLIENT_CREATE_DATABASE_USERNAME"
      value = var.postgres_user
    },
    {
      name  = "POSTGRESQL_CLIENT_CREATE_DATABASE_PASSWORD"
      value = random_string.postgres_password.result
    },
    {
      name  = "SMTP_AUTH"
      value = var.smtp_auth
    },
    {
      name  = "SMTP_HOST"
      value = var.smtp_host
    },
    {
      name  = "SMTP_PORT"
      value = var.smtp_port != null ? tostring(var.smtp_port) : ""
    },
    {
      name  = "SMTP_TLS"
      value = var.smtp_tls
    },
    {
      name  = "SMTP_USER"
      value = var.smtp_user
    },
    {
      name  = "SMTP_PASSWORD"
      value = var.smtp_password
    },
    {
      name  = "DISCOURSE_POSTGRESQL_NAME"
      value = var.postgres_name
    },
    {
      name  = "DISCOURSE_POSTGRESQL_USERNAME"
      value = var.postgres_user
    },
    {
      name  = "DISCOURSE_POSTGRESQL_PASSWORD"
      value = random_string.postgres_password.result
    },
    {
      name  = "DISCOURSE_HOST"
      value = aws_lb.discourse.dns_name
    },
    {
      name  = "DISCOURSE_USERNAME"
      value = var.discourse_username
    },
    {
      name  = "DISCOURSE_PASSWORD"
      value = random_string.discourse_password.result
    },
    {
      name  = "DISCOURSE_HOSTNAME"
      value = var.discourse_hostname
    },
    {
      name  = "DISCOURSE_EMAIL"
      value = var.discourse_email
    },
  ]

  container_definitions = [
    {
      name              = var.discourse_container_name
      image             = local.discourse_container_image
      cpu               = var.discourse_container_cpu
      memory            = var.discourse_container_memory
      memoryReservation = var.discourse_container_memory_reservation
      essential         = true
      portMappings      = [{
        containerPort = 3000
        hostPort      = 3000
        protocol      = "tcp"
      }]
      mountPoints = [{
        containerPath = "/bitnami"
        sourceVolume  = "bitnami-data"
        readOnly      = false
      }]
      environment = local.discourse_container_environment
      healthCheck = {
        command = [
          "CMD-SHELL",
          "curl -s http://localhost:3000/srv/status | grep ok",
        ]

        interval = 5
        timeout  = 2
        retries  = 3
      }
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = var.log_group_name
          awslogs-region        = data.aws_region.current.name
          awslogs-stream-prefix = var.discourse_container_name
        }
      }
    },
    {
      name              = var.sidekiq_container_name
      image             = local.sidekiq_container_image
      cpu               = var.sidekiq_container_cpu
      memory            = var.sidekiq_container_memory
      memoryReservation = var.sidekiq_container_memory_reservation
      essential         = true
      portMappings      = []
      mountPoints = [{
        containerPath = "/bitnami"
        sourceVolume  = "bitnami-data"
        readOnly      = false
      }]
      command     = ["nami", "start", "--foreground", "discourse-sidekiq"]
      environment = local.discourse_container_environment
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = var.log_group_name
          awslogs-region        = data.aws_region.current.name
          awslogs-stream-prefix = var.sidekiq_container_name
        }
      }
      dependsOn   = [{
        containerName = "discourse"
        condition     = "HEALTHY"
      }]
    }
  ]

  task_cpu = 1024
  task_memory = var.discourse_container_memory + var.sidekiq_container_memory

  cluster_tags = merge(var.tags, var.cluster_tags)
  task_tags = merge(var.tags, var.task_tags)
}