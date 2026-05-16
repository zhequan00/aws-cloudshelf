## CI/CD Pipeline

**Trigger:** Push to main branch

**Steps:**
1. Build Docker image from app/Dockerfile
2. Push to ECR using cloudshelf-cicd IAM user (scoped to ECR push only)
3. SSH into EC2, run start.sh which pulls new image and restarts container

**Secrets management:**
- AWS keys stored as GitHub Actions secrets (never in code)
- SSH private key stored as GitHub Actions secret
- DB credentials in ~/app.env on EC2 only (never committed)

**Auth split:**
- GitHub runner uses cloudshelf-cicd keys → ECR push
- EC2 uses instance profile → ECR pull (no credentials on instance)