# Configure the Azure Provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.11.0" # Or the latest version you prefer
    }
  }
  required_version = ">= 1.1.0" # Or the minimum version you require
}

# Connect to Azure
provider "azurerm" {
  features {}
}

# Create a resource group Called "Networking-Setup"
resource "azurerm_resource_group" "rg" {
  name     = "Networking-Setup"
  location = "East US"
}

# Create virtual network 1
resource "azurerm_virtual_network" "vnet1" {
  name                = "VNet1"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
    }

# Create virtual network 2
    resource "azurerm_virtual_network" "vnet2" {
        name                = "VNet2"
        address_space       = ["10.1.0.0/16"]
        location            = azurerm_resource_group.rg.location
        resource_group_name = azurerm_resource_group.rg.name
    }
    
# Peer the virtual networks
    resource "azurerm_virtual_network_peering" "vnet1_to_vnet2" {
        name                      = "VNet1-to-VNet2"
        resource_group_name       = azurerm_resource_group.rg.name
        virtual_network_name      = azurerm_virtual_network.vnet1.name
        remote_virtual_network_id = azurerm_virtual_network.vnet2.id
    }
    
    resource "azurerm_virtual_network_peering" "vnet2_to_vnet1" {
        name                      = "VNet2-to-VNet1"
        resource_group_name       = azurerm_resource_group.rg.name
        virtual_network_name      = azurerm_virtual_network.vnet2.name
        remote_virtual_network_id = azurerm_virtual_network.vnet1.id
    }

   # Create a subnet in VNet1
    resource "azurerm_subnet" "subnet1" {
        name                 = "Subnet1"
        resource_group_name  = azurerm_resource_group.rg.name
        virtual_network_name = azurerm_virtual_network.vnet1.name
        address_prefixes     = ["10.0.1.0/24"]
    }

    # Create a subnet in VNet2
    resource "azurerm_subnet" "subnet2" {
        name                 = "Subnet2"
        resource_group_name  = azurerm_resource_group.rg.name
        virtual_network_name = azurerm_virtual_network.vnet2.name
        address_prefixes     = ["10.1.1.0/24"]
    }

    # Create a network security group
    resource "azurerm_network_security_group" "nsg" {
        name                = "NSG"
        location            = azurerm_resource_group.rg.location
        resource_group_name = azurerm_resource_group.rg.name
    }
    # Create a security rule to allow SSH traffic
    resource "azurerm_network_security_rule" "allow_ssh" {
        name                        = "AllowSSH"
        priority                    = 100
        direction                   = "Inbound"
        access                      = "Allow"
        protocol                    = "Tcp"
        source_port_range           = "*"
        destination_port_range      = 22
        source_address_prefix       = "*"
        destination_address_prefix  = "*"
        network_security_group_name = azurerm_network_security_group.nsg.name
        resource_group_name = azurerm_resource_group.rg.name
    }
    # Associate the NSG with Subnet1
    resource "azurerm_subnet_network_security_group_association" "subnet1_nsg" {
        subnet_id                 = azurerm_subnet.subnet1.id
        network_security_group_id = azurerm_network_security_group.nsg.id
    }

    # Create a virtual interface in VNet1 Subnet1
    resource "azurerm_network_interface" "nic1" {
        name                = "NIC1"
        location            = azurerm_resource_group.rg.location
        resource_group_name = azurerm_resource_group.rg.name

        ip_configuration {
            name                          = "IPConfig1"
            subnet_id                    = azurerm_subnet.subnet1.id
            private_ip_address_allocation = "Dynamic"
        }
    }
    # Create a virtual interface in VNet2 Subnet2  
    resource "azurerm_network_interface" "nic2" {
        name                = "NIC2"
        location            = azurerm_resource_group.rg.location
        resource_group_name = azurerm_resource_group.rg.name

        ip_configuration {
            name                          = "IPConfig2"
            subnet_id                    = azurerm_subnet.subnet2.id
            private_ip_address_allocation = "Dynamic"
        }
    }
    
    # Create a virtual machine in VNet1 Subnet1
    resource "azurerm_virtual_machine1" "vm1" {
  name                  = "Virual Machine1"
  location              = azurerm_resource_group.rg.location
  resource_group_name   = azurerm_resource_group.rg.name
  network_interface_ids = [azurerm_network_interface.nic1.id]
  vm_size               = "Standard_DS1_v2"

  storage_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
  storage_os_disk {
    name              = "myosdisk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "hostname"
    admin_username = "testadmin"
    admin_password = "Password1234!"
  }
    }

    # Create a virtual machine in VNet2 Subnet2
    resource "azurerm_virtual_machine2" "vm2" {
  name                  = "Virtual Machine2"
  location              = azurerm_resource_group.rg.location
  resource_group_name   = azurerm_resource_group.rg.name
  network_interface_ids = [azurerm_network_interface.nic2.id]
  vm_size               = "Standard_DS1_v2"

  storage_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
  storage_os_disk {
    name              = "myosdisk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "hostname"
    admin_username = "testadmin"
    admin_password = "Password1234!"
  }
    }

