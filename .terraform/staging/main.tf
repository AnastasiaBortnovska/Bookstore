provider "aws" {
  region  = var.aws_region
}


data "template_file" "container_definitions" {
  template = "${file("templates/container_definition.json")}"

  vars = {
    web_server_ecr_repo = "711917579528.dkr.ecr.eu-central-1.amazonaws.com/nginx:latest"
    app_ecr_repo        = "711917579528.dkr.ecr.eu-central-1.amazonaws.com/bookstore:latest"
    version             = "latest"
    project_name        = "app"
    environment         = var.app_environment
    server_name         = var.server_name
    app_port            = 3000
    db_username         = var.db_username
    db_password         = var.db_password
    log_group           = module.global.aws_cloudwatch_log_group
    log_region          = var.aws_region
  }
}

module "global" {
  source = "../modules/global"

  app_name = var.app_name
}

module "ecs_cluster" {
  source = "../modules/ecs_cluster"

  app_name = var.app_name
  app_environment = var.app_environment
  subnet_ids = module.global.aws_subnet_ids
  load_balancer_security_group = aws_security_group.load_balancer_security_group.id
  instance_type = var.instance_type
  ecs_instance_iam_instance_profile = module.global.ecs_instance_iam_instance_profile
  container_definitions = data.template_file.container_definitions
  aws_lb_target_group = aws_lb_target_group.this.arn
  container_name   = "web-server"
  container_port   = 8080
}
