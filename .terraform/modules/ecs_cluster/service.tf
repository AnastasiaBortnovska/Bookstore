resource "aws_ecs_task_definition" "this" {
  family                   = var.app_name
  network_mode             = "bridge"
  cpu                      = var.cpu
  memory                   = var.memory

  container_definitions = var.container_definitions.rendered

  volume {
    name = "public"
  }

  volume {
    name = "postgres"

    docker_volume_configuration {
      scope         = "shared"
      autoprovision = true
    }
  }

  tags = {
    Name        = "${var.app_name}-ecs-td"
    Environment = var.app_environment
  }
}

resource "aws_ecs_service" "this" {
  name                               = var.app_name
  cluster                            = aws_ecs_cluster.this.id
  task_definition                    = aws_ecs_task_definition.this.arn
  desired_count                      = 1

   load_balancer {
    container_name   = var.container_name
    container_port   = var.container_port
    target_group_arn = var.aws_lb_target_group
  }

  lifecycle {
    ignore_changes = [desired_count]
  }
}