resource "aws_lb" "this" {
  name                       = var.app_name
  subnets                    = module.global.aws_subnet_ids
  load_balancer_type         = "application"
  security_groups            = [aws_security_group.load_balancer_security_group.id]
  enable_deletion_protection = false
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.this.arn
  port              = "80"
  protocol          = "HTTP"


  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this.arn
  }
}

resource "aws_lb_target_group" "this" {
  name                 = aws_lb.this.name
  port                 = "8080"
  protocol             = "HTTP"
  vpc_id               = module.global.vpc_id
  deregistration_delay = 30

  health_check {
    path                = "/"
    port                = "80"
    protocol            = "HTTP"
    timeout             = 5
    interval            = 30
    unhealthy_threshold = 2
    healthy_threshold   = 2
    matcher             = "200"
  }

  stickiness {
    type    = "lb_cookie"
    enabled = true
  }
}
