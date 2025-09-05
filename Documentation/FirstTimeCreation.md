Process Summary:
## 🔧 Manual Bootstrap (One-Time Setup)

Before running the pipeline for the first time, manually create the Terraform backend and ACR:

1. Create Resource Group  
2. Create Storage Account  
3. Create Blob Container (`rangersappstatecontainer`)  
4. Create Azure Container Registry (`rangersdockeracr`)  
5. Ensure Azure DevOps has service connections to the subscription and ACR

Once these are created, the pipeline can run end-to-end using remote state and push images to ACR.

# See Below for step by step:

## 🔧 Manual Bootstrap (One-Time Setup)

Before running the pipeline for the first time, manually create the Terraform backend:

1. Create Resource Group:
# - bash
   az group create --name rg-rangers-app --location uksouth

2. Create the Storage Account:
# - bash
az storage account create \
  --name rangersappstorageacct \
  --resource-group rg-rangers-app \
  --sku Standard_LRS


3. Create the Storage Container within the Storage Account
# - bash
az storage container create \
  --name rangersappstatecontainer \
  --account-name rangersappstorageacct


4. Create the Azure Container Registry to allow Dockerfile to be pushed during Pipeline process
# - bash
az acr create \
  --name rangersdockeracr \
  --resource-group rg-rangers-app \
  --sku Basic

# 🔐 Azure DevOps Setup - assuming a project is set up already - I've called mine FootballScores
1. Once the ACR is created:
2. Go to Azure DevOps → Project Settings → Service Connections
3. Add or confirm a connection to your Azure subscription - ARM registry (rangers-acr-service-connection)
4. Add a Docker Registry service connection pointing to your ACR (rangersdockeracr)
5. Ensure your pipeline references this connection in the Docker task


# This mirrors real-world Terraform workflows where backend state is bootstrapped manually for reliability and control.

# Once the backend has been created manually, the CICD pipeline can handle the rest and automate the process, creating the remaining Infra and the Web Application Creation and Deployment.



