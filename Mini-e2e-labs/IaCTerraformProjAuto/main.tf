terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
  }
}

provider "azurerm" {
  features {}
}

# -----------------------------
# Step 1: Create a Resource Group
# -----------------------------
resource "azurerm_resource_group" "devops_rg" {
  name     = "TerraformProj2"
  location = "West Europe"
}

# -----------------------------
# Step 2: Create a Storage Account for Terraform State
# -----------------------------
resource "azurerm_storage_account" "terraform_state" {
  name                     = "terraformstatestorage"
  resource_group_name      = azurerm_resource_group.devops_rg.name
  location                 = azurerm_resource_group.devops_rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "terraform_state_container" {
  name                  = "tfstate"
  storage_account_name  = azurerm_storage_account.terraform_state.name
}

# -----------------------------
# Step 3: Create a Virtual Network (VNet) and Subnet
# -----------------------------
resource "azurerm_virtual_network" "devops_vnet" {
  name                = "DevOpsVNet"
  location            = azurerm_resource_group.devops_rg.location
  resource_group_name = azurerm_resource_group.devops_rg.name
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "devops_subnet" {
  name                 = "DevOpsSubnet"
  resource_group_name  = azurerm_resource_group.devops_rg.name
  virtual_network_name = azurerm_virtual_network.devops_vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

# -----------------------------
# Step 4: Create a Network Security Group (NSG)
# -----------------------------
resource "azurerm_network_security_group" "devops_nsg" {
  name                = "DevOpsNSG"
  location            = azurerm_resource_group.devops_rg.location
  resource_group_name = azurerm_resource_group.devops_rg.name
}

# -----------------------------
# Step 5: Create a Network Interface (NIC)
# -----------------------------
resource "azurerm_network_interface" "devops_nic" {
  name                = "DevOpsNIC"
  location            = azurerm_resource_group.devops_rg.location
  resource_group_name = azurerm_resource_group.devops_rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.devops_subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

# -----------------------------
# Step 6: Create a Virtual Machine (VM) (FIXED RESOURCE NAME)
# -----------------------------
resource "azurerm_linux_virtual_machine" "devops_vm" {
  name                = "DevOpsVM"
  resource_group_name = azurerm_resource_group.devops_rg.name
  location            = azurerm_resource_group.devops_rg.location
  size                = "Standard_B2s"
  admin_username      = "azureuser"

  network_interface_ids = [azurerm_network_interface.devops_nic.id]
  disable_password_authentication = true

  admin_ssh_key {
    username   = "azureuser"
    public_key = file("~/.ssh/id_rsa.pub")
  }

  # os_disk block is now REQUIRED
  os_disk {
    name                 = "DevOpsOSDisk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }
}

# -----------------------------
# Step 7: Output the VM's Private IP
# -----------------------------
output "vm_private_ip" {
  value = azurerm_network_interface.devops_nic.ip_configuration[0].private_ip_address
}
