resource "aws_db_instance" "main" {
    identifier = "cloudshelf-db"
    engine = "mysql"
    engine_version = "8.4"
    instance_class = "db.t3.micro"
    allocated_storage = 20
    storage_type = "gp2"

    db_name = "cloudshelf"
    username = var.db_username
    password = var.db_password

    db_subnet_group_name = aws_db_subnet_group.main.name
    vpc_security_group_ids = [var.rds_sg_id]

    publicly_accessible     = false
  multi_az                = false
  backup_retention_period = 0

  skip_final_snapshot = true
  deletion_protection = false
  storage_encrypted = true
  auto_minor_version_upgrade = false
  copy_tags_to_snapshot    = true

  tags = {
    Project = "CloudShelf"
  }
}

resource "aws_db_subnet_group" "main" {
  name       = "cloudshelf-db-subnet-group"
  subnet_ids = var.subnet_ids

  tags = {
    Project = "CloudShelf"
  }
}

