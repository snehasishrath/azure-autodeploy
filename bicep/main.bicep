param location string = resourceGroup().location
param environment string = 'dev'

module network 'modules/network.bicep' = {
  name: 'network'
  params: {
    location: location
  }
}

module webapp 'modules/webapp.bicep' = {
  name: 'webapp'
  params: {
    location: location
    vnetName: network.outputs.vnetName
  }
}

module keyvault 'modules/keyvault.bicep' = {
  name: 'keyvault'
  params: {
    location: location
  }
}