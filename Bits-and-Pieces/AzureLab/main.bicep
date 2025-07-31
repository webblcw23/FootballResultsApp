// Creating a new resource group in Azure using Bicep
// The resource group is being created at subscription level, we need to specify this
targetScope = 'subscription'

param resourceGroupName string = 'myResourceGroup'
param location string = 'westeurope'

resource rg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: resourceGroupName
  location: location
}
