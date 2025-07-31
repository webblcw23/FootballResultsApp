# Basic settings
variable "rg_name" {
  type        = string
  description = "Name of the Azure Resource Group"
  default     = "rg-demo-lab"
}

variable "location" {
  type        = string
  description = "Azure region for all resources"
  default     = "uksouth"
}

variable "storage_account_name" {
  type        = string
  description = "Globally unique name for Azure Storage Account (3-24 lowercase letters/numbers)"
  default     = "demostoragewebb01"
}

# Network settings
variable "vnet_name" {
  type        = string
  description = "Name of the Virtual Network"
  default     = "demo-vnet"
}

variable "vnet_address_space" {
  type        = list(string)
  description = "CIDR block for the VNet"
  default     = ["10.0.0.0/16"]
}

variable "subnet_name" {
  type        = string
  description = "Name of the subnet"
  default     = "subnet1"
}

variable "subnet_address_prefix" {
  type        = list(string)
  description = "CIDR block for the subnet"
  default     = ["10.0.1.0/24"]
}

# NSG settings
variable "nsg_name" {
  type        = string
  description = "Name of the Network Security Group"
  default     = "demo-nsg"
}

# VM settings
variable "vm_admin_username" {
  type        = string
  description = "Admin username for the virtual machines"
  default     = "azureuser"
}

variable "vm_admin_password" {
  type        = string
  description = "Admin password for the virtual machines (not secure - demo only!)"
  default     = "P@ssword1234!"
}

variable "vm_size" {
  type        = string
  description = "Size of the virtual machines"
  default     = "Standard_B1s"
}

variable "vm_image" {
  type = object({
    publisher = string
    offer     = string
    sku       = string
    version   = string
  })
  description = "Linux image for the virtual machines"
  default = {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
}
