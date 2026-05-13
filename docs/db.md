# Database: RDS MySQL

## Connection Flow
Browser request → EC2 (Docker container) → env vars → RDS endpoint

## Security Design
- RDS SG allows port 3306 from cloudshelf-sg-ec2 only
- No public access
- Credentials injected via --env-file ~/app.env on EC2
- app.env never committed to git

## Endpoint
Available as Terraform output: `terraform output rds_endpoint`