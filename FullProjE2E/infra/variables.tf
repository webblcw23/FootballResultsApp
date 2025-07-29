
variable "resource_group_name" {
  description = "Name of the Azure Resource Group."
  type        = string
  default     = "rg-thefullproj" # You can change this
}

variable "location" {
  description = "Azure region for all resources."
  type        = string
  default     = "uksouth" # Choose a region near you, e.g., "eastus", "westeurope"
}

variable "aks_cluster_name" {
  description = "Name of the Azure Kubernetes Service cluster."
  type        = string
  default     = "aks-thefullproj"
}

variable "acr_name_prefix" {
  description = "Prefix for the Azure Container Registry name (a random suffix will be added)."
  type        = string
  default     = "thefullprojacr"
}

variable "key_vault_name_prefix" {
  description = "Prefix for the Azure Key Vault name (a random suffix will be added)."
  type        = string
  default     = "kv-thefullproj"
}

variable "vnet_address_space" {
  description = "CIDR block for the Virtual Network."
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "aks_subnet_address_prefix" {
  description = "CIDR block for the AKS subnet within the VNet."
  type        = string
  default     = "10.0.1.0/24"
}

variable "app_gateway_subnet_address_prefix" {
  description = "CIDR block for the Application Gateway subnet within the VNet (if used)."
  type        = string
  default     = "10.0.2.0/24"
}

variable "aks_node_vm_size" {
  description = "VM size for AKS worker nodes."
  type        = string
  default     = "Standard_DS2_v2" # Adjust based on your needs and budget
}

variable "aks_node_count" {
  description = "Number of nodes in the AKS default node pool."
  type        = number
  default     = 1 # Start with 1 for cost efficiency in a demo
}

variable "subscription_id" {
  description = "Azure Subscription ID for resource management."
  type        = string
  default     = "91c0fe80-4528-4bf2-9796-5d0f2a250518" 
  
}