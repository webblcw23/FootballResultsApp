# Security Design

## 🔐 Secrets Management
- All secrets (e.g. scraper config, API keys) stored in Azure Key Vault
- Accessed via Key Vault Reference syntax: `@Microsoft.KeyVault(...)`
- No secrets committed to source or exposed in pipelines

## 👤 Identity & RBAC
- Azure Function uses **SystemAssigned Managed Identity**
- Granted **Key Vault Secrets User** via scoped Terraform `azurerm_role_assignment`
- Azure DevOps uses RG-scoped service connection (least privilege)

## 🔒 Terraform Safety
- Uses remote state in RG-scoped Azure Storage
- Tags and naming help manage lifecycle and teardown
- Soft-delete and purge-protection disabled for demo re-deployability
