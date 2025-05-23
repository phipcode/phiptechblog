targetScope = 'subscription'

param subscriptionId string
param rgName string
param rgLocation string

param virtualMachines array = []

@description('Resource group for the application')
module resourceGroupForApplication 'br/public:avm/res/resources/resource-group:0.4.1' = {
  name: 'resourceGroupDeployment'
  scope: subscription(subscriptionId)
  params: {
    name: rgName
    location: rgLocation
  }
}

@description('Virtual Machine Module')
module virtualMachine './modules/virtualMachine/vm.bicep' = [
  for vm in virtualMachines: {
    scope: resourceGroup(rgName)
    dependsOn: [
      resourceGroupForApplication
    ]
    name: take('virtualMachineDeployment-${vm.name}', 64)
    params: {
      name: vm.name
      location: vm.location
      adminUsername: vm.adminUsername
      adminPassword: vm.adminPassword
      subnetId: vm.subnetId
      imageReference: vm.imageReference
      osDisk: vm.osDisk
      vmSize: vm.vmSize
    }
  }
]
