resource "aws_instance" "ec2" {
  ami                    = var.ami_id
  instance_type          = "t3.micro"
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [var.ec2_sg_id]
  iam_instance_profile   = var.instance_profile_name
  key_name               = var.key_name
  user_data_replace_on_change = false

  user_data = file("${path.module}/../../../scripts/bootstrap.sh")

  tags = {
    Name    = "cloudshelf-ec2"
    Project = "CloudShelf"
  }
}

resource "aws_eip" "ec2_eip" {
  instance = aws_instance.ec2.id
  domain   = "vpc"

  tags = {
    Name    = "cloudshelf-eip"
    Project = "CloudShelf"
  }
}

resource "aws_ecr_repository" "app" {
  name = "cloudshelf-app"
  force_delete = true

  image_scanning_configuration {
    scan_on_push = true
  }
}