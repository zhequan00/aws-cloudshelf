#!/bin/bash
set -euo pipefail

LOG=/var/log/bootstrap.log
exec > >(tee -a "$LOG") 2>&1

echo "=== CloudShelf bootstrap started: $(date) ==="

echo 'Acquire::ForceIPv4 "true";' | tee /etc/apt/apt.conf.d/99force-ipv4

# Update system
echo "Updating system packages..."
apt-get update -y
apt-get upgrade -y

# Install AWS CLI v2
echo "Installing AWS CLI..."
apt-get install -y unzip curl
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o /tmp/awscliv2.zip
unzip /tmp/awscliv2.zip -d /tmp
/tmp/aws/install
rm -rf /tmp/awscliv2.zip /tmp/aws

# Install Docker
echo "Installing Docker..."
apt-get install -y ca-certificates gnupg lsb-release
mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
  https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null
apt-get update -y
apt-get install -y docker-ce docker-ce-cli containerd.io

# Add ubuntu user to docker group
echo "Adding ubuntu to docker group..."
usermod -aG docker ubuntu

# Start and enable Docker
systemctl start docker
systemctl enable docker

echo "=== Bootstrap complete: $(date) ==="