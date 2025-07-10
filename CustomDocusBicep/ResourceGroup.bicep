targetScope = 'subscription'

var location = 'westus'
var resourceGroupName = 'myResourceGroupBicep'

resource resourceGroupCreate 'Microsoft.Resources/resourceGroups@2025-04-01' = {
  name: resourceGroupName
  location: location
}

// To deploy this resource Via Azure CLI, use the following command:
// az deployment sub create --location westus --template-file ResourceGroup.bicep --parameters resourceGroupName=myResourceGroupBicep
