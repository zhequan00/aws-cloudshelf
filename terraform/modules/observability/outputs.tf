output "bootstrap_log_group_name" {
    description = "CloudWatch log group name for bootstrap logs"
    value = aws_cloudwatch_log_group.bootstrap.name
}

output "docker_log_group_name" {
    description = "CloudWatch log group name for docker logs"
    value = aws_cloudwatch_log_group.docker.name  
}