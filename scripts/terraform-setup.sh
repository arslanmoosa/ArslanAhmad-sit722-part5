#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Step 1: Log in to Azure using the provided Service Principal credentials
# You need to set the following environment variables before running this script:
# AZURE_CLIENT_ID, AZURE_CLIENT_SECRET, AZURE_TENANT_ID, AZURE_SUBSCRIPTION_ID
echo "Logging in to Azure..."
az login

# Set the subscription ID

# Step 2: Install Terraform (if not installed)
if ! command -v terraform &> /dev/null; then
    echo "Terraform not found. Installing Terraform..."
    
    # Add the HashiCorp GPG key
    curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -

    # Add the HashiCorp repository
    sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"

    # Update package list
    sudo apt-get update

    # Install Terraform
    sudo apt-get install -y terraform
else
    echo "Terraform is already installed."
fi

# Step 3: Initialize Terraform

# Navigate to the Terraform directory containing your .tf files
cd terraform

# Initialize Terraform (only needed once)
echo "Initializing Terraform..."
terraform init

# Step 4: Apply all Terraform files
echo "Applying all Terraform configurations..."
terraform apply -auto-approve

# Step 5: Get the Kubernetes configuration from Terraform outputs
echo "Fetching Kubernetes config..."
KUBE_CONFIG=$(terraform output -raw kube_config)

# Write the Kubernetes config to ~/.kube/config for kubectl
echo "Writing Kubernetes config to ~/.kube/config..."
mkdir -p ~/.kube
echo "$KUBE_CONFIG" > ~/.kube/config

# Set KUBECONFIG environment variable
export KUBECONFIG=~/.kube/config

# Step 6: Verify Kubernetes Cluster Access
echo "Verifying Kubernetes cluster access..."
kubectl get nodes

echo "Terraform setup complete. Ready for Docker and Kubernetes deployment."

# Step 7: Log in to Azure Container Registry (ACR)
# Environment Variables: ACR_LOGIN_SERVER, ACR_USERNAME, ACR_PASSWORD
echo "Logging in to Azure Container Registry..."
docker login $ACR_LOGIN_SERVER -u $ACR_USERNAME -p $ACR_PASSWORD

# Step 8: Build and push Docker images to ACR
echo "Building and pushing Docker images..."
docker build -t $ACR_LOGIN_SERVER/book_catalog ./book_catalog
docker build -t $ACR_LOGIN_SERVER/inventory_management ./inventory_management
docker push $ACR_LOGIN_SERVER/book_catalog
docker push $ACR_LOGIN_SERVER/inventory_management

# Step 9: Deploy the microservices using Kubernetes
echo "Deploying microservices to AKS..."
kubectl apply -f book_catalog/deployment.yaml
kubectl apply -f inventory_management/deployment.yaml

echo "Deployment completed successfully!"
