targetScope = 'resourceGroup'

// Resource Group Name - myResourceGroupBicep

var location = 'westus'
var virtualNetwork1Name = 'vnet1'
var virtualNetwork2Name = 'vnet2'
var subnet1Name = 'Subnet-1'
var subnet2Name = 'Subnet-2'

resource virtualNetwork1 'Microsoft.Network/virtualNetworks@2024-07-01' = {
  name: virtualNetwork1Name
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.0.0.0/16'
      ]
    }
  }
  resource subnet1 'subnets' = {
    name: subnet1Name
    properties: {
      addressPrefix: '10.0.1.0/16'
    }
  }
}

resource virtualNetwork2 'Microsoft.Network/virtualNetworks@2024-05-01' = {
  name: virtualNetwork2Name
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.1.0.0/16'
      ]
    }
  }
  resource subnet2 'subnets' = {
    name: subnet2Name
    properties: {
      addressPrefix: '10.1.1.0/16'
    }
  }
}

resource virtualNetworkPeering1 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2024-07-01' = {
  name: 'vnet1-to-vnet2'
  parent: virtualNetwork1
  properties: {
    remoteVirtualNetwork: {
      id: virtualNetwork2.id
    }
    allowVirtualNetworkAccess: true
    allowForwardedTraffic: true
    allowGatewayTransit: false
    useRemoteGateways: false
  }
}
resource virtualNetworkPeering2 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2024-07-01' = {
  name: 'vnet2-to-vnet1'
  parent: virtualNetwork2
  properties: {
    remoteVirtualNetwork: {
      id: virtualNetwork1.id
    }
    allowVirtualNetworkAccess: true
    allowForwardedTraffic: true
    allowGatewayTransit: false
    useRemoteGateways: false
  }
}

resource nic1 'Microsoft.Network/networkInterfaces@2024-07-01' = {
  name: 'nic1'
  location: location
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          privateIPAllocationMethod: 'Dynamic'
          subnet: {
            id: virtualNetwork1::subnet1.id
          }
        }
      }
    ]
  }
}

resource nic2 'Microsoft.Network/networkInterfaces@2024-07-01' = {
  name: 'nic2'
  location: location
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig2'
        properties: {
          privateIPAllocationMethod: 'Dynamic'
          subnet: {
            id: virtualNetwork2::subnet2.id
          }
        }
      }
    ]
  }
}

resource vm1 'Microsoft.Compute/virtualMachines@2024-11-01' = {
  name: 'vm1'
  location: location
  properties: {
    hardwareProfile: {
      vmSize: 'Standard_DS1_v2'
    }
    storageProfile: {
      imageReference: {
        publisher: 'Canonical'
        offer: '0001-com-ubuntu-server-jammy'
        sku: '22_04-lts-gen2'
        version: 'latest'
      }
      osDisk: {
        createOption: 'FromImage'
      }
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: nic1.id
        }
      ]
    }
  }
}
resource vm2 'Microsoft.Compute/virtualMachines@2024-11-01' = {
  name: 'vm2'
  location: location
  properties: {
    hardwareProfile: {
      vmSize: 'Standard_DS1_v2'
    }
    storageProfile: {
      imageReference: {
        publisher: 'Canonical'
        offer: '0001-com-ubuntu-server-jammy'
        sku: '22_04-lts-gen2'
        version: 'latest'
      }
      osDisk: {
        createOption: 'FromImage'
      }
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: nic2.id
        }
      ]
    }
  }
}

output subnet1ResourceId string = virtualNetwork1::subnet1.id
output subnet2ResourceId string = virtualNetwork2::subnet2.id
output nic1ResourceId string = nic1.id
output nic2ResourceId string = nic2.id

// To check this deployment via Azure CLI, use the following command with whatif option:
// az deployment group what-if --resource-group myResourceGroupBicep --template-file Network.bicep

// To deploy this to Azure via Azure CLI, use the following command:
// az deployment group create --resource-group myResourceGroupBicep --template-file Network.bicep --parameters location=westus virtualNetwork1Name=vnet1 virtualNetwork2Name=vnet2 subnet1Name=Subnet-1 subnet2Name=Subnet-2
