variable "app_name" {
  description = "Application name"
}

variable "app_environment" {
  type        = string
  description = "Application Environment"
}

variable "subnet_ids" {
  description = "Subnet ids to launch ECS cluster instances in"
}

variable "load_balancer_security_group" {
  description = "Security group for load balancer"
}

variable "ecs_instance_iam_instance_profile" {
  description = "IAM instance profile with ECS instance role"
}

variable "container_definitions" {
  description = "Container definitions"
}

variable "aws_lb_target_group" {
  description = "Provides a Target Group resource for use with Load Balancer resources"
}

variable "container_name" {
  description = "Container Name"
}

variable "container_port" {
  description = "Container Port"
}

variable "instance_type" {
  type        = string
  description = "Instance type EC2"
}