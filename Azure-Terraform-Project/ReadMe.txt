# 🔧 Azure Infrastructure Automation with Terraform & PowerShell

This project provisions a simple cloud environment in Microsoft Azure using [Terraform](https://www.terraform.io/) and automates deployment using PowerShell. It serves as a personal lab to demonstrate core DevOps and Infrastructure as Code (IaC) skills.

## 🚀 What It Deploys

- ✅ Azure Resource Group
- ✅ Azure Storage Account
- ✅ Virtual Network (VNet) and Subnet
- ✅ Network Security Group (NSG) with basic SSH access
- ✅ Two Ubuntu Linux Virtual Machines
- ✅ Fully parameterized using `variables.tf`

## 🛠 Tech Stack

- **Azure** – Cloud platform for infrastructure
- **Terraform** – Infrastructure as Code provisioning
- **PowerShell** – Local deployment automation
- **Azure CLI** – Used for authentication and setup
- *(Optional)* **Azure DevOps / GitHub Actions** – CI/CD pipeline support

## 🧪 How to Use

1. Ensure [Terraform](https://developer.hashicorp.com/terraform/downloads) and [Azure CLI](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli) are installed
2. Authenticate to Azure:
   ```bash
   az login
