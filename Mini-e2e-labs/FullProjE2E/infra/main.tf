
# Azure Resource Group
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

# Azure Container Registry (ACR) - Name must be globally unique!
resource "azurerm_container_registry" "acr" {
  name                = var.acr_name_prefix # Now just uses the prefix from variables.tf
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku                 = "Basic"
  admin_enabled       = true # Enable admin user for easy pipeline integration (consider disabling in production for security)
}

# Azure Key Vault - Name must be globally unique!
data "azurerm_client_config" "current" {} # Used to get your Azure AD tenant ID

resource "azurerm_key_vault" "kv" {
  name                = var.key_vault_name_prefix # Now just uses the prefix from variables.tf
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku_name            = "standard"
  tenant_id           = data.azurerm_client_config.current.tenant_id
  enabled_for_disk_encryption = false
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false
}

resource "azurerm_key_vault_secret" "app_secret" {
  name         = "MyAppTestSecret"
  value        = "ThisIsATestValue123!" # Replace with a placeholder. Never commit real secrets.
  key_vault_id = azurerm_key_vault.kv.id
  content_type = "text/plain"
}

# Virtual Network (VNet)
resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-${var.resource_group_name}"
  address_space       = var.vnet_address_space
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

# Subnet for AKS nodes
resource "azurerm_subnet" "aks_subnet" {
  name                 = "aks-subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.aks_subnet_address_prefix]
}

# Subnet for Application Gateway (if you decide to add one later for ingress)
resource "azurerm_subnet" "app_gateway_subnet" {
  name                 = "appgateway-subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.app_gateway_subnet_address_prefix]
}

# Log Analytics Workspace (for AKS monitoring)
resource "azurerm_log_analytics_workspace" "workspace" {
  name                = "loganalytics-${var.resource_group_name}" # Suffix removed
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "PerGB2018" # Standard SKU for pricing
}

# Azure Kubernetes Service (AKS) Cluster
resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.aks_cluster_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "${var.aks_cluster_name}-dns" # Must be unique globally, might need manual adjustment if conflicts

  sku_tier           = "Free" # For learning/dev. "Standard" is recommended for production.
  kubernetes_version = "1.27.3" # Check Azure docs for latest stable supported version

  default_node_pool {
    name                = "systempool"
    node_count          = var.aks_node_count
    vm_size             = var.aks_node_vm_size
    vnet_subnet_id      = azurerm_subnet.aks_subnet.id
    os_disk_size_gb     = 30
  }

  identity {
    type = "SystemAssigned" # Enable system-assigned managed identity for AKS cluster
  }

  # Enable Azure Monitor for containers (OMS Agent)
  oms_agent {
    log_analytics_workspace_id = azurerm_log_analytics_workspace.workspace.id
  }

  network_profile {
    network_plugin     = "azure" # Azure CNI is recommended for advanced networking features
    dns_service_ip     = "10.0.0.10" # Must be within VNet CIDR but outside any subnet range
    service_cidr       = "10.0.3.0/24" # Non-overlapping with VNet CIDR
  }

  role_based_access_control_enabled = true # Always use RBAC

  tags = {
    environment = "dev"
    project     = "thefullproj"
  }
}