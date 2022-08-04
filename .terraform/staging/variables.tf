variable "aws_region" {
  type        = string
  description = "AWS Region"
}

variable "app_name" {
  type        = string
  description = "Application Name"
}

variable "app_environment" {
  type        = string
  description = "Application Environment"
}

variable "db_username" {
  type        = string
  description = "DB User Name"
}

variable "db_password" {
  type        = string
  description = "DB password"
}

variable "server_name" {
  type        = string
  description = "Server Name"
}

variable "instance_type" {
  type        = string
  description = "Instance type EC2"
}

variable "cpu" {
  description = "The number of CPU units used by the task"
}

variable "memory" {
  description = "The amount (in MiB) of memory used by the task"
}