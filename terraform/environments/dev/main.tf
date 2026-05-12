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
}