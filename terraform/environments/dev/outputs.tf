output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnet_1a_id" {
  value = module.vpc.public_subnet_1a_id
}

output "public_subnet_1b_id" {
  value = module.vpc.public_subnet_1b_id
}

output "ec2_sg_id" {
  value = module.vpc.ec2_sg_id
}

output "rds_sg_id" {
  value = module.vpc.rds_sg_id
}

output "rds_endpoint" {
  value = module.rds.rds_endpoint
}

output "website_url" {
  description = "S3 static website URL"
  value       = module.frontend.website_url
}

output "bootstrap_log_group" {
  description = "CloudWatch log group for bootstrap logs"
  value       = module.observability.bootstrap_log_group_name
}

output "docker_log_group" {
  description = "CloudWatch log group for Docker logs"
  value       = module.observability.docker_log_group_name
}

output "ec2_instance_id" {
  description = "EC2 instance ID"
  value       = module.compute.instance_id
}