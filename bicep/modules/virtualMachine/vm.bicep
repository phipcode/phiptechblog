@description('Name of the virtual machine')
param name string

@description('Location for the VM')
param location string

@description('Admin username')
param adminUsername string

@description('Admin password')
@secure()
param adminPassword string

@description('Subnet ID for NIC')
param subnetId string

@description('Image reference')
param imageReference object = {
  offer: 'WindowsServer'
  publisher: 'MicrosoftWindowsServer'
  sku: '2022-datacenter-azure-edition'
  version: 'latest'
}

@description('OS disk settings')
param osDisk object = {
  caching: 'ReadWrite'
  diskSizeGB: 128
  managedDisk: {
    storageAccountType: 'StandardSSD_LRS'
  }
}

@description('VM size')
param vmSize string = 'Standard_D2s_v3'

module virtualMachine 'br/public:avm/res/compute/virtual-machine:0.15.0' = {
  name: 'virtualMachineDeployment'
  params: {
    adminUsername: adminUsername
    adminPassword: adminPassword
    imageReference: imageReference
    name: name
    nicConfigurations: [
      {
        ipConfigurations: [
          {
            name: 'ipconfig01'
            subnetResourceId: subnetId
          }
        ]
        nicSuffix: '-nic-01'
      }
    ]
    osDisk: osDisk
    osType: 'Windows'
    vmSize: vmSize
    zone: 0
    location: location
  }
}
