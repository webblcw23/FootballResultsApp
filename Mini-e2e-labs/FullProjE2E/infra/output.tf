
output "resource_group_name" {
  value       = azurerm_resource_group.rg.name
  description = "The name of the resource group."
}

output "aks_cluster_name" {
  value       = azurerm_kubernetes_cluster.aks.name
  description = "The name of the AKS cluster."
}

output "acr_login_server" {
  value       = azurerm_container_registry.acr.login_server
  description = "The login server for Azure Container Registry."
}

output "key_vault_uri" {
  value       = azurerm_key_vault.kv.vault_uri
  description = "The URI of the Azure Key Vault."
}

output "aks_kube_config" {
  value       = azurerm_kubernetes_cluster.aks.kube_config_raw
  sensitive   = true # Mark as sensitive to prevent showing in plain text in logs
  description = "The raw Kubernetes config for connecting to the AKS cluster."
}

output "subscription_id" {
  value       = var.subscription_id
  description = "The Azure Subscription ID used for resource management."
  
}