param resourceGroupName string = 'myResourceGroup'
param location string = 'eastus' // Change to your desired location

//creating resource group
resource resourceGroup 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: resourceGroupName
  location: location
}
//outputs
output resourceGroupId string = resourceGroup.id
