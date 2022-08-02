resource "aws_autoscaling_group" "cluster-instance" {
  name                      = "${var.app_name}-asg"
  vpc_zone_identifier       = var.subnet_ids
  desired_capacity          = 2
  min_size                  = 2
  max_size                  = 2
  health_check_grace_period = 30

  launch_template {
    id = aws_launch_template.this.id
  }
}