
set -e
echo "Logging in to Azure..."
az login

if ! command -v terraform &> /dev/null; then
    echo "Terraform not found. Installing Terraform..."
    curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
    sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
    sudo apt-get update

    # Install Terraform
    sudo apt-get install -y terraform
else
    echo "Terraform is already installed."
fi

cd ./terraform
terraform init
terraform apply -auto-approve
