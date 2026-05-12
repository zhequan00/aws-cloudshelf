variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID to launch EC2 in"
  type        = string
}

variable "ec2_sg_id" {
  description = "Security group ID for EC2"
  type        = string
}

variable "instance_profile_name" {
  description = "IAM instance profile name to attach"
  type        = string
}

variable "key_name" {
  description = "Key pair name for SSH access"
  type        = string
}