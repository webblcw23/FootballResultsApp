# RangersApp ⚽  
An Azure cloud-native, CI/CD-powered web app that scrapes and serves Rangers FC match results — deployed end-to-end on Azure.

## Overview  
RangersApp is a fully automated web application that scrapes Rangers FC match results, packages them into a Dockerized .NET frontend, and deploys to Azure via Terraform and Azure DevOps. Built to showcase platform engineering skills, CI/CD automation, and infrastructure-as-code.
With a welcome page, main results page with clever 'back' buttons to help navigate the app. Simple yet effective.


## Architecture and Folder Setup 

[Terraform] → [Azure DevOps Pipeline]
     └── RG, ACR, Web App, Storage
          └── Python Scraper → JSON
               └── Docker Build → ACR Push
                    └── Azure Web App Deploy


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
5. App deployed to Azure Web App Dev, Staging and Produciton with approval gates for Staging Prod.

## Security Practices  
- No secrets in code — credentials handled via Azure DevOps service connections through variables and secret toggle On
- RBAC enforced for service principals  
- Terraform state stored securely in Azure Blob Storage  
- Key Vault mock Secret has been added for 'football-data-api-key' to demonstate Key Vault integreation into YAML pipe and Terraform 
  

## Monitoring & Observability  
- Logging available via Azure Web App diagnostics and Deployment Centre for Web App start logs.
- App Insights and health checks planned  
- Alerting and uptime tracking on the roadmap  


## Local Development  
#- bash
# Run scraper
python3 Data/scrape_scores.py

# Build and run locally
docker build -t rangersapp:local .
docker run -p 5050:80 rangersapp:local


----- Kubernetes extra ------
# Adding a Local Test for Kubernetes via MiniKube
# Esnure Minikube is running 
minikube start
# Build image via docker
docker build -t rangersapp:local .  
# Push Docker Image to Minikube
minikube image load rangersapp:local
# Then create the deployment and service using:
kubectl apply -f k8s/deployment.yaml
kubectl apply -f k8s/service.yaml
# Manually forwarding the port using:
kubectl port-forward svc/rangersapp-service 8080:80
# Open URL
http://localhost:8080/

# Note
Local testing completed successfully through dotnet run before testing with Docker. Once successful, pushed to Azure via automated Pipeline


## Planned Enhancements  
- 🔐 Key Vault Integration  - To Store secret (Variable is fine for now but ideal for best practice)
- 📈 Monitoring & Alerts  - Web App default alert is on but this can be improved.
- 🧪 Unit Testing  - Add unit test scripts to ensure working application before deployment.
- 🚀 Staging Environment  - Currently there is no middle ground before a 'prod' deployment.
- 🧱 Terraform Modules  - Cleanly organise my IaC using a modular strategy.


## Project Outcome 
This project demonstrates full-stack platform ownership, real-world CI/CD troubleshooting, infrastructure-as-code usage, and secure cloud deployment. Built with resilience, iteration, and a focus on maintainability.



