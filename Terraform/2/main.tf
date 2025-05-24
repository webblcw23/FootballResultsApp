# Connect to Azure provider§
provider "azurerm" {
  features {}
  subscription_id =  "91c0fe80-4528-4bf2-9796-5d0f2a250518"
}

# User parameters
variable "admin_username" {
  description = "The admin username for the VM"
  type        = string

}   
variable "admin_password" {
  description = "The password for the admin user"
  type        = string
  sensitive   = true
}

# Create a resource group
resource "azurerm_resource_group" "example" {
  name     = "ResourceGroup-MiniProject-2"
  location = "West Europe"
}

# Create a virtual network
resource "azurerm_virtual_network" "example" {
  name                = "VNet-MiniProject-2"
  address_space       = ["10.0.1.0/16"]
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
}

# Create a subnet
resource "azurerm_subnet" "example" {
  name                 = "Subnet-MiniProject-2"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.0.1.1/24"]
}

# Create a second virtual network
resource "azurerm_virtual_network" "example2" {
  name                = "VNet-MiniProject-2-2"
  address_space       = ["10.0.2.0/16"]
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
}
# Create a second subnet
resource "azurerm_subnet" "example2" {
  name                 = "Subnet-MiniProject-2-2"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example2.name
  address_prefixes     = ["10.0.2.1/24"]
}

# Create a peer connection between the Vnet1 and Vnet2
resource "azurerm_virtual_network_peering" "example" {
  name                      = "VNet-Peering-MiniProject-2"
  resource_group_name       = azurerm_resource_group.example.name
  virtual_network_name      = azurerm_virtual_network.example.name
  remote_virtual_network_id = azurerm_virtual_network.example2.id

  allow_virtual_network_access = true
}
# Create a second peer connection between the Vnet2 and Vnet1
resource "azurerm_virtual_network_peering" "example2" {
  name                      = "VNet-Peering-MiniProject-2-2"
  resource_group_name       = azurerm_resource_group.example.name
  virtual_network_name      = azurerm_virtual_network.example2.name
  remote_virtual_network_id = azurerm_virtual_network.example.id

  allow_virtual_network_access = true
}

# Create a VM in subent1
resource "azurerm_linux_virtual_machine" "example" {
  name                = "VM-MiniProject-2"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  size               = "Standard_DS1_v2"
  admin_username      = var.admin_username
  admin_password      = var.admin_password
  network_interface_ids = [
    azurerm_network_interface.example.id,
  ]

  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
}
# Create a network interface for the VM
resource "azurerm_network_interface" "example" {
  name                = "NIC-MiniProject-2"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  ip_configuration {
    name                          = "internal"
    subnet_id                    = azurerm_subnet.example.id
    private_ip_address_allocation = "Dynamic"
  }
}
# Create a VM in subent2
resource "azurerm_linux_virtual_machine" "example2" {
  name                = "VM-MiniProject-2-2"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  size               = "Standard_DS1_v2"
  admin_username      = var.admin_username
  admin_password      = var.admin_password
  network_interface_ids = [
    azurerm_network_interface.example2.id,
  ]

  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
}
# Create a network interface for the VM
resource "azurerm_network_interface" "example2" {
  name                = "NIC-MiniProject-2-2"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  ip_configuration {
    name                          = "internal"
    subnet_id                    = azurerm_subnet.example2.id
    private_ip_address_allocation = "Dynamic"
  }
}

# Create a storage account
resource "azurerm_storage_account" "example" {
  name                     = "storageaccountproj2"
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}
# Create a storage container
resource "azurerm_storage_container" "example" {
  name                  = "containerforproj2"
  storage_account_name  = azurerm_storage_account.example.name
  container_access_type = "private"
}
