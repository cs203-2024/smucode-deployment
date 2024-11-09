resource "aws_db_instance" "db" {
  for_each = var.databases

  identifier        = each.value.identifier
  port              = 5432
  allocated_storage = 20
  db_name           = each.key
  engine            = "postgres" # Changed from "postgresql" to "postgres"
  engine_version    = "15.5"
  instance_class    = "db.t3.micro"
  username          = var.db_username
  password          = var.db_password

  vpc_security_group_ids = [var.db_sg_id]
  db_subnet_group_name   = var.subnet_group_name

  skip_final_snapshot = true
  publicly_accessible = false
}
