output "vpc_id" {
  value = data.aws_vpc.default.id
}

output "aws_subnet_ids" {
  value = data.aws_subnet_ids.default.ids
}

output "ecs_instance_iam_instance_profile" {
  value = aws_iam_instance_profile.ecs_instance.name
}

output "aws_cloudwatch_log_group" {
  value = aws_cloudwatch_log_group.this.name
}