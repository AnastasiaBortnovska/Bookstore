data "aws_ami" "ecs_optimized" {
  owners      = ["amazon"]
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-ecs-hvm-2.0.20191114-x86_64-ebs"]
  }
}

resource "aws_launch_template" "this" {
  name                   = "${var.app_name}-lt"
  instance_type          = var.instance_type
  vpc_security_group_ids = [var.load_balancer_security_group]
  image_id               = data.aws_ami.ecs_optimized.id
  user_data              = base64encode(<<EOF
  #!/bin/sh

{
  echo "ECS_CLUSTER=${aws_ecs_cluster.this.name}"
} >> /etc/ecs/ecs.config
start ecs
EOF
)

  iam_instance_profile {
    name = var.ecs_instance_iam_instance_profile
  }
}