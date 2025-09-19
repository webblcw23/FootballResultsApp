# RangersApp ⚽  
An Azure cloud-native, CI/CD-powered web app that scrapes and serves Rangers FC match results — deployed end-to-end on Azure with Development, Staging and Production Environments.
- View the /Documentation folder for screenshots.
  
## Overview  
RangersApp is a cloud-native, CI/CD-driven web app that turns match data into a production-grade experience — built to showcase secure DevOps, modular infrastructure, and platform ownership


## Architecture and Folder Setup 

[Azure DevOps Pipeline Flow]

└── Core Infrastructure (rg-rangers-core)
    ├── Create ACR (Azure Container Registry)
    ├── Optional: Provision Storage Account & Key Vault
    └── Run Python Scraper → Generate latest JSON data
        └── Docker Build → Push image to ACR (multi-tag: dev/staging/prod)

└── Dev Environment (rg-rangers-dev)
    ├── Terraform Apply → Provision Web App & resources
    ├── Tagging system → Pull dev image (e.g. rangersapp:dev-001)
    └── Web App Restarted → Validate container startup

└── Staging Environment (rg-rangers-staging)
    ├── Terraform Apply → Provision gated staging infra
    ├── Tagging system → Pull staging image (e.g. rangersapp:staging-001)
    └── Web App Restarted → Pre-prod validation

└── Production Environment (rg-rangers-prod)
    ├── Terraform Apply → Provision gated prod infra
    ├── Tagging system → Pull prod image (e.g. rangersapp:prod-001)
    └── Web App Restarted → Live deployment

               

## Tech Stack  
- ASP.NET Core (.NET 8)  - Web App creation using C#  
- Python (Pandas for scraping)  - To allow Results Scraping onto a .json file
- Docker  - App containerization 
- Azure DevOps Pipelines - Automating Creation and Deployment + Results Updates
- Terraform  - IaC for Azure Infra set up
- Azure App Service, ACR, Storage, Resource Group  - Azure resources for the app

## CI/CD Flow  
1. Pipeline triggers weekly to update Results 
2. Python script scrapes latest results  
3. Docker image built with freshly updated JSON  
4. Image pushed to Azure Container Registry  (ACR)
5. App deployed to Azure Web App for Dev -> Staging (Gated) -> Produciton (Gated)
6. Web App restarted to serve new data

| Scraper |  -> | Docker |  -> | ACR | -> | Dev | -> | Staging | -> | Prod |


## Security Practices  
- No secrets in code — credentials handled via Azure DevOps service connections through variables and secret toggle On
- RBAC enforced for service principals  
- Terraform state stored securely in Azure Blob Storage  
- Key Vault mock Secret can been added for 'football-data-api-key' to demonstate Key Vault integreation into YAML pipe and Terraform 
  

## Monitoring & Observability  
- Logging available via Azure Web App diagnostics  
- App Insights and health checks planned  
- Alerting and uptime tracking on the roadmap  


# Run scraper cmd for local run 
python3 Data/scrape_scores.py

# Build and run locally
docker build -t rangersapp:local .
docker run -p 5050:80 rangersapp:local


----- Kubernetes extra ------
# Adding a Local Test for Kubernetes via MiniKube
- Ensure Minikube is running 
minikube start
- Build image via docker
docker build -t rangersapp:local .  
- Push Docker Image to Minikube
minikube image load rangersapp:local
- Then create the deployment and service using:
kubectl apply -f k8s/deployment.yaml
kubectl apply -f k8s/service.yaml
- Manually forwarding the port using:
kubectl port-forward svc/rangersapp-service 8080:80
- Open URL
http://localhost:8080/

# Note
Local testing completed successfully through dotnet run before testing with Docker. Once successful, pushed to Azure via automated Pipeline


## Planned Enhancements  
- 🔐 Key Vault Integration  - To Store secret (Pipeline Variable used for client secret is fine for now but ideal for best practice)
- 📈 Monitoring & Alerts  - Web App default alert is on but this can be improved.
- 🧪 Unit Testing  - Add unit test scripts to ensure working application before deployment.


## Project Outcome 
This project demonstrates full-stack platform ownership, real-world CI/CD troubleshooting, multiple environments, infrastructure-as-code usage, and secure cloud deployment. Built with resilience, iteration, and a focus on maintainability.


