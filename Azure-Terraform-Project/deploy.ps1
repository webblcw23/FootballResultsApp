# deploy.ps1 - Simple PowerShell deployment for Terraform

Write-Host "Starting Terraform deployment..."

# Initialize Terraform
terraform init

# Preview infrastructure changes
terraform plan

# Apply the changes
terraform apply -auto-approve

Write-Host "Deployment complete!"
