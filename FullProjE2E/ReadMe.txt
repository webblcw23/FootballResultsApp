This MAIN end to end mini proj demonstrates design, automation, and a secure Azure-based Kubernetes deployment using Terraform, Key Vault, and Azure DevOps pipelines.
It includes, at a high level, the following:
Using a simple flask app which is containerised using Docker
IaC (Terrafrom) 
CI/CD automation (Azure DevOps)
Kubernetes orchestration via AKS
Secret management via Azure Key Vault and RBAC


Visualised:

    DevOps[Azure DevOps Pipeline] --> Terraform[Provision Infra]
    Terraform --> AKS[Azure Kubernetes Service]
    Terraform --> KV[Azure Key Vault]
    Terraform --> ACR[Azure Container Registry]
    App[Flask App] --> Docker[Containerized Image]
    Docker --> ACR
    ACR --> AKS
    KV --> AKS
    Logs[Monitoring + Cost Control] --> AKS

