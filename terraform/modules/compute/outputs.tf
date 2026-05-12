output "instance_id" {
  description = "EC2 instance ID"
  value       = aws_instance.ec2.id
}

output "public_ip" {
  description = "Elastic IP address"
  value       = aws_eip.ec2_eip.public_ip
}