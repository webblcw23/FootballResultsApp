# 🚀 Azure Terraform DevOps Demo

This project demonstrates how to define and validate infrastructure using Terraform, targeting Azure resources such as Resource Groups and App Services. The setup is wired for DevOps pipelines and focuses on **mocking real-world infrastructure securely and efficiently**—perfect for learning or portfolio use without incurring costs.

---

## 🏗️ What’s Inside

- **Terraform IaC** for deploying:
  - Azure Resource Group
  - Azure App Service Plan & Web App
- **Modular structure** with input variables and outputs
- **Cost-safe by design**: Plans infrastructure without applying real resources
- **YAML Pipeline** (Azure DevOps) to automate linting and validation

---

## 💡 Architecture Overview

```plaintext
Azure Resource Group
├── App Service Plan (Free Tier)
└── Web App (linked to the plan)
