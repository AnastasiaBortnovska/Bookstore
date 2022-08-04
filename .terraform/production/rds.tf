resource "aws_db_instance" "this" {
  db_name                      = "bookstore_dev"
  engine                       = "postgres"
  engine_version               = "12.8"
  instance_class               = "db.t3.micro"
  allocated_storage            = 5
  storage_type                 = "gp2"
  username                     = var.db_username
  password                     = var.db_password
  publicly_accessible          = true
  multi_az                     = false
  skip_final_snapshot          = true
  vpc_security_group_ids       = [aws_security_group.db_server.id]
}