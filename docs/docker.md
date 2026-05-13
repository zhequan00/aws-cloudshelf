# Docker & ECR Flow

## Image Build
- Base image: python:3.11-slim (~51MB)
- Built locally with `docker build -t cloudshelf-app ./app`

## ECR Auth Flow
- Local push: uses personal IAM credentials via `aws configure`
- EC2 pull: uses IAM instance profile, no credentials stored on instance
- Auth token is short-lived (12hrs), fetched via `aws ecr get-login-password`

## Deployment
- Container runs detached (`-d`) on EC2
- Port mapping: EC2:80 → container:5000
- EC2 security group allows port 80 inbound (configured in Phase 1)