#go to folder
cd Terraform_Showcase_Project

# log into azure
az login
# show subscription
az account show

# validate terraform
terraform validate

# initilise folder
terraform init

# plan and apply
terraform plan
terraform apply -auto-approve