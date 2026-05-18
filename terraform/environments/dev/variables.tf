variable "my_ip" {
  description = "Local IP for SSH access in CIDR notation"
  type        = string
}

variable "project" {
  description = "Project name used for tagging"
  type        = string
  default     = "cloudshelf"
}

variable "account_id" {
  description = "AWS account ID"
  type        = string
}

variable "ami_id" {
  description = "AMI ID for EC2"
  type        = string
}

variable "db_username" {
  type = string
}

variable "db_password" {
  type      = string
  sensitive = true
}
