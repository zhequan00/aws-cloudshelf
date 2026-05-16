#!/bin/bash
set -euo pipefail

ECR_REGISTRY="126104434582.dkr.ecr.ap-southeast-1.amazonaws.com"
IMAGE_NAME="cloudshelf-app"
CONTAINER_NAME="cloudshelf-app"

echo "==> Authenticating Docker to ECR..."
aws ecr get-login-password --region ap-southeast-1 | \
  docker login --username AWS --password-stdin "$ECR_REGISTRY"

echo "==> Pulling latest image..."
docker pull "$ECR_REGISTRY/$IMAGE_NAME:latest"

echo "==> Stopping existing container (if running)..."
docker stop "$CONTAINER_NAME" 2>/dev/null || true
docker rm "$CONTAINER_NAME" 2>/dev/null || true

echo "==> Starting new container..."
docker run -d \
  --name "$CONTAINER_NAME" \
  --env-file ~/app.env \
  -p 80:5000 \
  --restart unless-stopped \
  "$ECR_REGISTRY/$IMAGE_NAME:latest"

echo "==> Done. Container status:"
docker ps --filter "name=$CONTAINER_NAME"