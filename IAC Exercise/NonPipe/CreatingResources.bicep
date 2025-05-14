// Parameters for location and resource group
param location string = 'westeurope' // Specify the Azure region
param resourceGroupName string = 'QuickSetUp' // Name of the resource group
param adminUsername string = 'azureuser' // Admin username for the VM
param adminPassword string = 'P@ssw0rd1234!' // Admin password for the VM (use a secure password)

// Variables for the Virtual Network
var vnetName = 'QuickVNet' // Name of the Virtual Network
var addressSpace = [
  '10.0.0.0/16' // Address space for the VNet
]

// Create the Virtual Network
resource virtualNetwork 'Microsoft.Network/virtualNetworks@2021-05-01' = {
  name: vnetName
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: addressSpace
    }
  }
}

// Create a Subnet within the Virtual Network
resource subnet1 'Microsoft.Network/virtualNetworks/subnets@2024-05-01' = {
  name: 'subnet1'
  parent: virtualNetwork
  properties: {
    addressPrefix: '10.0.1.0/24' // Address prefix for the subnet
  }
}

// Create Secondary Subnet
resource subnet2 'Microsoft.Network/virtualNetworks/subnets@2024-05-01' = {
  name: 'subnet2'
  parent: virtualNetwork
  properties: {
    addressPrefix: '10.0.2.0/24' // Address prefix for the secondary subnet
  }
}

// Create a Public IP Address
resource publicIP 'Microsoft.Network/publicIPAddresses@2021-05-01' = {
  name: 'QuickPublicIP'
  location: location
  properties: {
    publicIPAllocationMethod: 'Dynamic' // Allocation method for the public IP
  }
}

// Create a Network Security Group
resource nsg 'Microsoft.Network/networkSecurityGroups@2021-05-01' = {
  name: 'QuickNSG'
  location: location
  properties: {
    securityRules: [
      {
        name: 'AllowRDP'
        properties: {
          protocol: 'Tcp'
          sourcePortRange: '*'
          destinationPortRange: '3389' // RDP port
          sourceAddressPrefix: '*'
          destinationAddressPrefix: '*'
          access: 'Allow'
          priority: 1000
          direction: 'Inbound'
        }
      }
    ]
  }
}

// Create a Network Interface and attach to subnet1
resource networkInterface1 'Microsoft.Network/networkInterfaces@2021-05-01' = {
  name: 'QuickNIC1'
  location: location
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          privateIPAllocationMethod: 'Dynamic'
          subnet: {
            id: subnet1.id
          }
          publicIPAddress: {
            id: publicIP.id
          }
        }
      }
    ]
    networkSecurityGroup: {
      id: nsg.id
    }
  }
}

// Create a VM1 and attach to networkInterface1
resource vm1 'Microsoft.Compute/virtualMachines@2021-03-01' = {
  name: 'QuickVM1'
  location: location
  properties: {
    hardwareProfile: {
      vmSize: 'Standard_DS1_v2' // VM size
    }
    osProfile: {
      computerName: 'QuickVM1'
      adminUsername: adminUsername
      adminPassword: adminPassword // For real world purposes I would call the password for Key Vault
    }
    storageProfile: {
      imageReference: {
        publisher: 'MicrosoftWindowsServer'
        offer: 'WindowsServer'
        sku: '2019-Datacenter'
        version: 'latest'
      }
      osDisk: {
        createOption: 'FromImage'
      }
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: networkInterface1.id
        }
      ]
    }
  }
}
