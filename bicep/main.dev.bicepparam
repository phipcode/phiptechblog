using 'main.bicep'

param subscriptionId  = 'sub-id'
param rgName = 'arg-syd-workload-example'
param rgLocation = 'australiaeast'
param virtualMachines = [
  {
    name: 'vm-dev-01'
    location: 'australiaeast'
    adminUsername: 'azureuser'
    adminPassword: 'SuperSecurePassword123!'
    subnetId: '/subscriptions/sub-id/resourceGroups/arg-syd-workload-prod-network/providers/Microsoft.Network/virtualNetworks/vnt-syd-workload-prod-10.52.5.0_24/subnets/privateEndpoints'
    imageReference: {
      offer: 'WindowsServer'
      publisher: 'MicrosoftWindowsServer'
      sku: '2022-datacenter-azure-edition'
      version: 'latest'
    }
    osDisk: {
      caching: 'ReadWrite'
      diskSizeGB: 256
      managedDisk: {
        storageAccountType: 'StandardSSD_LRS'
      }
    }
    vmSize: 'Standard_D4s_v3'
  }
]
