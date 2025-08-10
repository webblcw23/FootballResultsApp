# Rangers FC Tracker — Secure, Serverless Azure Platform

- Frontend: Azure Storage Static Website
- Backend: Azure Functions (.NET 8 isolated)
- Secrets: Azure Key Vault via Managed Identity
- CI/CD: Azure DevOps (Build → Plan → Approve → Apply → Deploy → Smoke)
- IaC: Terraform (remote state in Azure Storage)

## Why this project
A personal, real-time fan app that demonstrates secure cloud automation, least-privilege access, and cost-aware design.

## Architecture
Diagram: browser → static site → Functions API → external sports API
Security: RBAC, no secrets in repo, Key Vault refs, managed identity

## Pipelines
- Build: publish static + functions
- Plan: Terraform plan (remote state)
- Apply: manual approval
- Deploy: upload static, zip deploy functions, smoke tests

## Cost controls
- Serverless consumption + static hosting
- Free quotas + sampling
- Teardown script included
