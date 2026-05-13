output "instance_id" {
  description = "EC2 instance ID"
  value       = aws_instance.ec2.id
}

output "public_ip" {
  description = "Elastic IP address"
  value       = aws_eip.ec2_eip.public_ip
}

output "ecr_repository_uri" {
  value = aws_ecr_repository.app.repository_url
}