terraform {
    required_providers {
      aws = {
        source = "hashicorp/aws"
        version = "~> 5.0"
      }
    }
}

provider "aws" {
    region = "ap-southeast-1"
}

module "vpc" {
    source  = "../../modules/vpc"
    project = var.project
    my_ip = var.my_ip
}

module "iam" {
  source = "../../modules/iam"
  account_id = var.account_id
}

module "compute" {
  source                = "../../modules/compute"
  ami_id                = var.ami_id
  subnet_id             = module.vpc.public_subnet_1a_id
  ec2_sg_id             = module.vpc.ec2_sg_id
  instance_profile_name = module.iam.ec2_instance_profile_name
  key_name              = "cloudshelf-key"
}

module "rds" {
  source = "../../modules/rds"

  db_username = var.db_username
  db_password = var.db_password
  rds_sg_id = module.vpc.rds_sg_id
  subnet_ids = module.vpc.public_subnet_ids
}

module "frontend" {
  source = "../../modules/frontend"
  bucket_name = "cloudshelf-frontend-126104434582"
}