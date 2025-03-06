// Parameters
param location string = 'uksouth' // Specify your desired location
param resourceGroupName string = 'MyNewResourceGroup' // Specify the resource group name

// Resource Group
resource rg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: resourceGroupName
  location: location
}

// Outputs
output resourceGroupId string = rg.id
