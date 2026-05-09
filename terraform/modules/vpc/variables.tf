variable "vpc_cidr" {
    description = "CIDR block for the VPC"
    type = string
    default = "10.0.0.0/16"
}

variable "project" {
    description = "Project name used for tagging"
    type = string
    default = "cloudshelf"
}

variable "my_ip" {
  description = "Your local IP for SSH access in CIDR notation"
  type        = string
}